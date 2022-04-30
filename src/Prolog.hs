module Prolog
   ( Term(..), var, cut
   , Clause(..), rhs
   , VariableName(..), Atom, Unifier, Substitution, Program, Goal
   , unify, unify_with_occurs_check
   , apply
   , MonadTrace(..)
   , withTrace
   , MonadGraphGen(..)
   , runNoGraphT
   , resolve, resolve_
   , (+++)
   , consult, consultString, parseQuery
   , program, whitespace, comment, clause, terms, term, bottom, vname
   , main, repl
   )
where

import Syntax
import Parser
import Unifier
import Interpreter

main = do
   putStrLn "Prolog Interpreter."
   putStr "What file has the database? "
   fname <- getLine
   db <- consult fname
   case db of
     Left foo -> error $ show foo
     Right bar -> repl bar

repl :: Program -> IO ()
repl program = do
   putStr "> "
   query <- getLine
   case parseQuery query of
     Left err -> putStrLn $ "Error: " ++ show err
     Right q -> do result <- resolve program q
                   putStrLn $ show result
   repl program

