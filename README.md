# POSIX shell SemVer

A posix shell function that captures the fragments of the
[Semantic Versioning Specification][1]. This repo also contains a short
script that runs the function against a set of example version numbers to check
its validity.

This uses only built-in POSIX shell commands. Think of it as
an extension to the [suggested regex FAQ entry][2] for use in sh and 
other posix compliant shells.


## Usage

```sh
#!/usr/bin/env sh

. "./semver.sh"

if semver "$1"; then
    echo "Major: $major";
    echo "Minor: $minor";
    echo "Patch: $patch";
    [ -n "$prerelease" ] && echo "Pre-release: $prerelease"
    [ -n "$buildmetadata" ] && echo "Build Metadata: $buildmetadata"
else 
    echo "No match found!";
fi 
```

## Original Source

This repo came to life following a [discussion in an issue][3] in the semver
repo on GitHub. See [here][3]. Forked from [here][4] which implements a version for bash.


[1]: https://semver.org/
[2]: https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string
[3]: https://github.com/semver/semver/issues/981
[4]: https://github.com/har7an/bash-semver-regex
