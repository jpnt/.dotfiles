# How to use this Vim config:

My configuration is heavily inspired by Max Cantor's presentation called 'How to Do 90% of What Plugins Do (With Just Vim)', if you are interested go check it out!

Please view this file in raw format (some text disappears when converted to markdown).

# Recently used files

- r + Ctrl + f to open recent files
- (this is a map of :browse old) 

# Find files

- :find <file>
- *. to make it fuzzy
- :b to autocomplete open buffers
  
# File browsing

- :e to edit a file 
- type 'vim .' to open file tree
- (:Ex also opens a file tree)
- <CR>/v/t to open in horizontal, vertical or tabbed
- :help netrw-browse-maps
- (<CR> is Enter/Return key)

# Autocompletion

- ^n for anything specified
- ^n for next suggestion
- ^p for previous suggestion
- ^x^n just for this file
- ^x^f for filenames
- ^x^] for tags only
- :help ins-completion

# Tag jumping (Ctags)

- :MakeTags to create tags file 
- :ts <tag> to search tag
- :tn tag next
- :tp tag previous
- :ts to list definitions of last tag
- ^] to jump to tag underneath cursor
- ^t to jump back in tag stack
- g^] for tags in entire code base

# Tag browser (Tagbar)

- F8 for :TagbarToggle
- Ctrl + w + h/l to navigate into Tagbar

# Build integration (vim-test)

- t + Ctrl + n for :TestNearest
- t + Ctrl + f for :TestFile
- t + Ctrl + s for :TestSuite
- t + Ctrl + l for :TestLast
- t + Ctrl + g for :TestVisit

# Snippets

- ,html gives html snippet (.skeleton.html)
- (We can also add more snippets)

# Advice

- use :help and :helpgrep
- vimtutor
- don't use arrow keys
