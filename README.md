# OWL-API IRI Patch

The owl-api has a bug when resolving the IRI for the main ontology if the same
IRI is used as part of an annotation for the ontology. A PR has been raised in
https://github.com/owlcs/owlapi/pull/1117 to solve this.

In the meanwhile, there is no easy way to fix this without having to clone
the owl-api version and apply the patch manually. This repo adds a patch for both
owl-api v4.x and v5.x. 

## Requirements

- Git
- sed
- Bash shell interpreter.

## How to use

```bash
owlapi_patch_install.sh OWL_API_GIT_DIR VERSION
```

where:
- `OWL_API_GIT_DIR`: The directory where you cloned the owl-api
- `VERSION`: The owl-api version you cloned (`v4` or `v5`).

## Notes

This patch adds a message to the `api/src/main/java/org/semanticweb/owlapi/util/VersionInfo.java` to indicate that 
this is an owl-api patched version. As the owl-api has some tests that check for length of serialized files with
owl-api adding this message will break these tests. When building this patched version skip tests with maven (`-DskipTests`).