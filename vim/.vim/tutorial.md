# How to use this Vim config:

# Find files

- :find <file>
- *. to make it fuzzy
- :b autocomplete open buffers

# Tag jumping (Ctags)

- :MakeTags to create tags file 
- :ts <tag> to search tag
- :tn tag next
- :tp tag previous
- :ts to list definitions of last tag
- ^] to jump to tag underneath cursor
- ^t to jump back in tag stack
- g^] for tags in entire code base

# Autocompletion

- ^x^n just for this file
- ^x^f for filenames
- ^x^] for tags only
- ^n for anything specified
- ^n for next suggestion
- ^p for previous suggestion
- :help ins-completion

# File browsing

- :edit a folder
- type 'vim .'
- <CR>/v/t to open in horizontal, vertical or tabbed
- :help netrw-browse-maps
- (<CR> is Enter/Return key)

# Snippets

- ,html gives html snippet (.skeleton.html)
- (We can also add more snippets)

# Advice

- use :help and :helpgrep
- vimtutor
- don't use arrow keys
