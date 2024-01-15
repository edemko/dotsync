#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <tree_sitter/parser.h>

enum TokenType {
  // TODO add external token types
  SENTINEL
};


struct state {
  // TODO define necessary parser state
};

////// Creation and Destruction //////

void* tree_sitter_TODO_LANGUAGE_NAME_external_scanner_create() {
  assert(sizeof(struct state) <= TREE_SITTER_SERIALIZATION_BUFFER_SIZE);

  struct state* st = malloc(sizeof(struct state));
  if (st == NULL) { return st; }
  // TODO initialize state
  return st;
}

void tree_sitter_TODO_LANGUAGE_NAME_external_scanner_destroy(void* payload) {
  free(payload);
}

////// Codec //////

unsigned tree_sitter_TODO_LANGUAGE_NAME_external_scanner_serialize
  (void* payload, char* buffer) {
  struct state* st = payload;

  // TODO implement serializer
  assert(false);
}

void tree_sitter_TODO_LANGUAGE_NAME_external_scanner_deserialize
  (void* payload, const char* buffer, unsigned length) {
  struct state* st = payload;

  // TODO implement deserializer
  assert(false);
}

////// Lexing //////

bool tree_sitter_TODO_LANGUAGE_NAME_external_scanner_scan
  (void* payload, TSLexer* lexer, const bool* valid_symbols) {
  if (valid_symbols[SENTINEL]) {
    return false;
  }

  struct state* st = payload;

  // TODO implement scanning algorithm
  assert(false);
}

