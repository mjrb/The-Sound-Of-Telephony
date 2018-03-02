# The Sound Of Telephony

converts phone numbers into music

## Overview

origonally i wrote this as a command line thing in ruby that used musescore from the command line. it was way to slow and i'm doing it client side with web in mind this time.

## Setup

Most of the following scripts require [rlwrap](http://utopia.knoware.nl/~hlub/uck/rlwrap/).

Build your project once in dev mode with the following script and then open `index.html` in your browser.

    ./scripts/build

To auto build your project in dev mode:

    ./scripts/watch

To start an auto-building Node REPL:

    ./scripts/repl

To get source map support in the Node REPL:

    lein npm install
    
To start a browser REPL:
    
1. Uncomment the following lines in src/the_sound_of_telephony/core.cljs:
```clojure
;; (defonce conn
;;   (repl/connect "http://localhost:9000/repl"))
```
2. Run `./scripts/brepl`
3. Browse to `http://localhost:9000` (you should see `Hello world!` in the web console)
4. (back to step 3) you should now see the REPL prompt: `cljs.user=>`
5. You may now evaluate ClojureScript statements in the browser context.
    
For more info using the browser as a REPL environment, see
[this](https://github.com/clojure/clojurescript/wiki/The-REPL-and-Evaluation-Environments#browser-as-evaluation-environment).
    
Clean project specific out:

    lein clean
     
Build a single release artifact with the following script and then open `index_release.html` in your browser.

    ./scripts/release

## License

Copyright © 2018 Mickey J Winters

Distributed under the Eclipse Public License either version 1.0.
