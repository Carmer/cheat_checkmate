# Cheat Checkmate

This app is built for education in mind. At Turing School of Software and Design we get hundreds of submissions a module and it is difficult to manually spot plagiarism. Though plagiarism is not a pervasive issue it is something to take seriously.

Currently, this script is set up to work with github.

You will need to know the following information to execute this script:

The flagged student's `:github_username`, `:github_repository_name`, and `:path_to_file`
The Comparison student's `:github_username`, `:github_repository_name`, and `:path_to_file`

You will need to set some environment variables:

```bash
export GITHUB_CLIENT_ID='your-github-client-id'
export GITHUB_CLIENT_SECRET='your-github-client-SECRET'
export GITHUB_USER_AGENT='your-github-username'

```
## Current Features:

To user Cheat Checkmate, just clone down this ruby script and execute it in your terminal.

You can execute the command fairly easily:

```terminal
⎈ ruby app.rb :flagged_github_username :flagged_github_reposityor_name :flagged_github_file_name :comparison_github_username :comparison_github_reposityor_name :comparison_github_file_name

```

If there are collisions you may see an output like this:

```terminal
$ ⎈ ruby app.rb carmer MovieTime 'app/controllers/application/controller.rb' turingschool MovieTime 'app/controllers/application/controller.rb'
Collisions: 5
================
{
    "Line: 1" => "  class ApplicationController < ActionController::Base",
    "Line: 2" => "    # Prevent CSRF attacks by raising an exception.",
    "Line: 3" => "    # For APIs, you may want to use :null_session instead.",
    "Line: 4" => "    protect_from_forgery with: :exception",
    "Line: 5" => "  end"

```

**Please not in the example above I compared the same files from the same user.
