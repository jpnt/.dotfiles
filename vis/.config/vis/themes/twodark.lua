-- Vis editor theme: GitHub Dark / OneDarker hybrid
-- Minimal, high-contrast, productivity-focused

local lexers = vis.lexers

local colors = {
    ['base00'] = '#0d1117',  -- GitHub dark background
    ['base01'] = '#161b22',  -- Secondary background
    ['base02'] = '#21262d',  -- Selection/Highlight
    ['base03'] = '#484f58',  -- Comments/Line numbers
    ['base04'] = '#6e7681',  -- Secondary text
    ['base05'] = '#c9d1d9',  -- Primary text
    ['base06'] = '#ecf2f8',  -- Bright text
    ['base07'] = '#ffffff',  -- White
    ['base08'] = '#ff7b72',  -- Red (errors)
    ['base09'] = '#d29922',  -- Orange (numbers)
    ['base0A'] = '#e3b341',  -- Yellow (types)
    ['base0B'] = '#7ee787',  -- Green (strings)
    ['base0C'] = '#79c0ff',  -- Blue (operators)
    ['base0D'] = '#a5d6ff',  -- Light blue (functions)
    ['base0E'] = '#d2a8ff',  -- Purple (keywords)
    ['base0F'] = '#ffa198',  -- Soft red (warnings)
}

lexers.colors = colors

local fg = ',fore:'..colors.base05..','
local bg = ',back:'..colors.base00..','

lexers.STYLE_DEFAULT = bg..fg
lexers.STYLE_NOTHING = bg
lexers.STYLE_CLASS = 'fore:'..colors.base0A
lexers.STYLE_COMMENT = 'fore:'..colors.base03..',italics'
lexers.STYLE_CONSTANT = 'fore:'..colors.base09
lexers.STYLE_DEFINITION = 'fore:'..colors.base0E
lexers.STYLE_ERROR = 'fore:'..colors.base08
lexers.STYLE_FUNCTION = 'fore:'..colors.base0D
lexers.STYLE_KEYWORD = 'fore:'..colors.base0E..',bold'
lexers.STYLE_LABEL = 'fore:'..colors.base0A
lexers.STYLE_NUMBER = 'fore:'..colors.base09
lexers.STYLE_OPERATOR = 'fore:'..colors.base0C
lexers.STYLE_REGEX = 'fore:'..colors.base0B
lexers.STYLE_STRING = 'fore:'..colors.base0B
lexers.STYLE_PREPROCESSOR = 'fore:'..colors.base0A
lexers.STYLE_TAG = 'fore:'..colors.base0A
lexers.STYLE_TYPE = 'fore:'..colors.base0A
lexers.STYLE_VARIABLE = 'fore:'..colors.base05
lexers.STYLE_WHITESPACE = 'fore:'..colors.base02
lexers.STYLE_EMBEDDED = 'fore:'..colors.base0F
lexers.STYLE_IDENTIFIER = 'fore:'..colors.base08

-- Interface styling
lexers.STYLE_LINENUMBER = 'fore:'..colors.base03..',back:'..colors.base00
lexers.STYLE_CURSOR = 'fore:'..colors.base00..',back:'..colors.base05
lexers.STYLE_CURSOR_PRIMARY = 'fore:'..colors.base00..',back:'..colors.base05
lexers.STYLE_CURSOR_LINE = 'back:'..colors.base01
lexers.STYLE_COLOR_COLUMN = 'back:'..colors.base01
lexers.STYLE_SELECTION = 'back:'..colors.base02
lexers.STYLE_STATUS = 'fore:'..colors.base04..',back:'..colors.base01
lexers.STYLE_STATUS_FOCUSED = 'fore:'..colors.base05..',back:'..colors.base01..',bold'
lexers.STYLE_SEPARATOR = lexers.STYLE_DEFAULT