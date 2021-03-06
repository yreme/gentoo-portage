#!/bin/bash

source tests-common.sh

inherit flag-o-matic

CFLAGS="-a -b -c=1"
CXXFLAGS="-x -y -z=2"
LDFLAGS="-l -m -n=3"
ftend() {
	local ret=$?
	local msg="Failed; flags are:"
	local flag
	for flag in $(all-flag-vars) ; do
		msg+=$'\n\t'"${flag}=${!flag}"
	done
	tend ${ret} "${msg}"
}

tbegin "is-flag"
! (is-flag 1 2 3) 2>/dev/null
ftend

tbegin "is-ldflag"
! (is-ldflag 1 2 3) 2>/dev/null
ftend

while read exp flag ; do
	[[ -z ${exp}${flag} ]] && continue

	tbegin "is-flagq ${flag}"
	is-flagq ${flag}
	[[ ${exp} -eq $? ]]
	ftend
done <<<"
	1	-L
	0	-a
	0	-x
"

while read exp flag ; do
	[[ -z ${exp}${flag} ]] && continue

	tbegin "is-ldflagq ${flag}"
	is-ldflagq "${flag}"
	[[ ${exp} -eq $? ]]
	ftend
done <<<"
	1	-a
	0	-n=*
	1	-n
"

tbegin "strip-unsupported-flags"
strip-unsupported-flags
[[ ${CFLAGS} == "" ]] && [[ ${CXXFLAGS} == "-z=2" ]]
ftend

for var in $(all-flag-vars) ; do
	eval ${var}=\"-filter -filter-glob -foo-${var%FLAGS}\"
done

tbegin "filter-flags basic"
filter-flags -filter
(
for var in $(all-flag-vars) ; do
	val=${!var}
	[[ ${val} == "-filter-glob -foo-${var%FLAGS}" ]] || exit 1
done
)
ftend

tbegin "filter-flags glob"
filter-flags '-filter-*'
(
for var in $(all-flag-vars) ; do
	val=${!var}
	[[ ${val} == "-foo-${var%FLAGS}" ]] || exit 1
done
)
ftend

tbegin "strip-flags basic"
CXXFLAGS+=" -O999 "
strip-flags
[[ -z ${CFLAGS}${LDFLAGS}${CPPFLAGS} && ${CXXFLAGS} == "-O2" ]]
ftend

tbegin "replace-flags basic"
CFLAGS="-O0 -foo"
replace-flags -O0 -O1
[[ ${CFLAGS} == "-O1 -foo" ]]
ftend

tbegin "replace-flags glob"
CXXFLAGS="-O0 -mcpu=bad -cow"
replace-flags '-mcpu=*' -mcpu=good
[[ ${CXXFLAGS} == "-O0 -mcpu=good -cow" ]]
ftend

tbegin "append-cflags basic"
CFLAGS=
append-cflags -O0
[[ ${CFLAGS} == " -O0" ]]
ftend

tbegin "append-cflags -DFOO='a b c'"
CFLAGS=
append-cflags '-DFOO="a b c"'
[[ ${CFLAGS} == ' -DFOO="a b c"' ]]
ftend

tbegin "raw-ldflags"
LDFLAGS='-Wl,-O1 -Wl,--as-needed -Wl,-z,now -flto'
LDFLAGS=$(raw-ldflags)
[[ ${LDFLAGS} == '-O1 --as-needed -z now' ]]
ftend

texit
