#!/usr/bin/env zunit
#{{{ MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Tue Feb 25 19:37:50 EST 2020
##### Purpose: zsh script to
##### Notes:
#}}}***********************************************************
#
@setup {
    load ~/.zpwr/.shell_aliases_functions.sh
    TEST_FILE=tests/testfile
}

@test 'zshrc exists' {
	test -f install/.zshrc
    assert $? equals 0
}

@test 'perl scripts syntax check' {
	for file in scripts/*.pl;do
        run perl -c $file
        assert $? equals 0
    done

}
