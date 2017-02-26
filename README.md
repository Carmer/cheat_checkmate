# Cheat Checkmate

This app is built for education in mind. At Turing School of Software and Design we get hundreds of submissions a module and it is difficult to manually spot plagiarism. Though plagiarism is not a pervasive issue it is something to take seriously.

Currently, this script is set up to work with github.

You will need to know the following information to execute this script:

The flagged student's `:github_username`, `:github_repository_name`, and `:github_file_name`
The Comparison student's `:github_username`, `:github_repository_name`, and `:github_file_name`

## Current Features:

To user Cheat Checkmate, just clone down this ruby script and execute it in your terminal.

You can execute the command fairly easily:

```terminal
⎈ ruby app.rb :flagged_github_username :flagged_github_reposityor_name :flagged_github_file_name :comparison_github_username :comparison_github_reposityor_name :comparison_github_file_name

```

If there are collisions you may see an output like this:

```terminal
$ ⎈ ruby app.rb carmer MovieTime readme turingschool MovieTime readme
Collisions: 3
================
{
    "Line: 1" => "  # MovieTime",
    "Line: 3" => "  Let's practice some rails",
    "Line: 5" => "  fin"
}
```

**Please not in the example above I compared the same files from the same user. 
