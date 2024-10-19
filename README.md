## FORGE - minimal

This is a simple demo for a presentation on Interpreters.

Forge is a minimal interpreted dinamic language that supports only integers arithmetic operations for now.

If you want to try it, you can run on docker:

```bash
docker compose run --rm forge-minimal bash
```

And then run the tests:

```bash
bundle exec rspec
```

Or you can run the interpreter:

```bash
ruby repl/repl.rb
```

And type some expressions like:

```bash
> var x = 10
> x + 20
> x * 2
> x / 2
> x - 5
```

## Basic concepts of an Interpreter

An interpreter is a program that reads a program and executes it.

The basic concepts of an interpreter are:

- Lexer: reads the source code and generates tokens
- Parser: reads the tokens and generates an Abstract Syntax Tree (AST)
- AST: a tree representation of the program
- Evaluator: reads the AST and executes the program