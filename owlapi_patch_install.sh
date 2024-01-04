#!/bin/bash

# Get the directory of the script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <directory_path> <version>"
  exit 1
fi

# Assign the input directory path and version to variables
directory_path="$1"
version="$2"

echo "Applying OWL API patch by github.com/vChavezB to $1"

# Add Patch message to serialized owl ontologies
sed -i 's!by the OWL API !by the OWL API + IRI Patch https://github.com/vChavezB/owl-api_iri_patch !g' "$directory_path/api/src/main/java/org/semanticweb/owlapi/util/VersionInfo.java"

# Disable java doc for building in maven
sed -i 's!<no-javadoc>false</no-javadoc>!<no-javadoc>true</no-javadoc>!g' "$directory_path/pom.xml"

echo "Patch applied!"

# Change directory to the git repository
cd "$directory_path" || exit 1

# Apply git patch based on the version argument
if [ "$version" == "v4" ]; then
  echo "Applying v4 patch..."
  git apply "$script_dir/patch_v4.diff"
elif [ "$version" == "v5" ]; then
  echo "Applying v5 patch..."
  git apply "$script_dir/patch_v5.diff"
else
  echo "Invalid version argument. Supported versions are v4 and v5."
  exit 1
fi

echo "Git patch applied for version $version."
