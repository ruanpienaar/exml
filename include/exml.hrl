%%%-------------------------------------------------------------------
%%% Parts of this file, explicitly marked in the code, were taken from
%%% https://github.com/erszcz/rxml
%%%-------------------------------------------------------------------

-ifndef(EXML_HEADER).
-define(EXML_HEADER, true).

-record(xmlcdata, {content = [] :: iodata()}).

-record(xmlel, {name :: binary(),
                attrs = [] :: [exml:attr()],
                children =  [] :: [exml:element() | exml:cdata()]}).

%% Implementation of the exmlAssertEqual/2 macro is an exact copy of
%% https://github.com/erszcz/rxml/commit/e8483408663f0bc2af7896e786c1cdea2e86e43d#diff-2cb5d18741df32f4ead70c21fdd221d1
%% See assertEqual in $ERLANG/lib/stdlib-2.6/include/assert.hrl for the original.
-define(exmlAssertEqual(Example, Expr),
        begin
            ((fun (__E, __V) ->
                      case __V of
                          __E -> ok;
                          __V -> erlang:error({exmlAssertEqual,
                                               [{module, ?MODULE},
                                                {line, ?LINE},
                                                {expression, (??Expr)},
                                                {expected, __E},
                                                {value, __V}]})
                      end
              end)(exml:xml_sort((Example)), exml:xml_sort((Expr))))
        end).

-endif.
