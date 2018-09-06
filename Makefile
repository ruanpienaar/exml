.PHONY: rel deps test

all: deps compile

compile: rebar3
	./rebar3 compile

deps: rebar3
	./rebar3 get-deps

clean: rebar3
	./rebar3 clean

test-deps: rebar3
	./rebar3 get-deps

test-compile: rebar3 test-deps
	./rebar3 compile

test: test-compile
	./rebar3 eunit

coverage-report: $(shell ls -1rt `find .eunit -type f -name \*.coverdata 2>/dev/null` | tail -n1)
	erl -noshell -pa ebin deps/*/ebin -eval 'ecoveralls:travis_ci("$?"), init:stop()'

rebar3:
	wget https://github.com/erlang/rebar3/releases/download/3.6.1/rebar3 &&\
	chmod u+x rebar3

dialyzer: rebar3
	./rebar3 dialyzer
