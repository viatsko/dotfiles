New-Item -Path ~\.editorconfig -ItemType SymbolicLink -Value (Get-Item ".\..\.editorconfig").FullName
New-Item -Path ~\.gitignore -ItemType SymbolicLink -Value (Get-Item ".\..\.gitignore").FullName
New-Item -Path ~\.gitconfig -ItemType SymbolicLink -Value (Get-Item ".\..\.gitconfig").FullName
New-Item -Path ~\.vim -ItemType SymbolicLink -Value (Get-Item ".\..\.vim").FullName
New-Item -Path ~\.vimrc -ItemType SymbolicLink -Value (Get-Item ".\..\.vimrc").FullName
