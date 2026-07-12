#  sdg-pkg update 0.4.2
    
## changelog 0.4.1.1 > 0.4.2

added new repo management functionality:

subcommand `repo`

sdgpkg repo list:
lists installed repositories with their priority and their URL

sdgpkg repo fetch:
fetches available repositories from the central repolist

sdgpkg repo add:
adds a repository either from a url to a .repo file or from the repolist

sdgpkg repo remove:
removes a repository using grep-based matching


#  sdg-pkg update 0.4.1.1
    
## changelog 0.4.1 > 0.4.1.1

replaced repo with proper github one
#  sdg-pkg update 0.4.1
    
## changelog 0.4 > 0.4.1

minor changes and fixes to branch and changelog commands
#  sdg-pkg update 0.4
    
## changelog 0.3 > 0.4

added branch commands: branch list and branch switch

branch list:
`sdgpkg branch list <packagename>`

will list the branches available for a package

branch switch:
`sdgpkg branch switch <packagename> <branch>`

switches the local cached repository to that branch


workflow:

`sdgpkg sync <packagename>` - to sync the repo down
`sdgpkg branch list <packagename>` - to see what branches the repo has
`sdgpkg branch switch <packagename> <branch>` - to switch the branch
'sdgpkg install <packagename>'/`sdgpkg update <packagename>` - install package from that branch or update to that branch.


added changelog command:
`sdgpkg changelog <package>`

pulls the latest section of the changelog from the git repository. 

 
#  sdg-pkg update 0.3
    
## changelog  0.2 > 0.3

instantiated repo with sdgbuild
