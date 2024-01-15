module.exports = grammar(
  { name: 'TODO_LANGUAGE_NAME'

  , rules:
    { source_file: $ => 'hello'
      // TODO: add the actual grammar rules
    }

  , externals: $ =>
    [ // TODO add any external token types
    ]
  , extras: $ =>
    [
    ]

  })
