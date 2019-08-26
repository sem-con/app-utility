define("ace/mode/ruby_highlight_rules",["require","exports","module","ace/lib/oop","ace/mode/text_highlight_rules"],function(e,t){"use strict";var r=e("../lib/oop"),n=e("./text_highlight_rules").TextHighlightRules,a=t.constantOtherSymbol={token:"constant.other.symbol.ruby",regex:"[:](?:[A-Za-z_]|[@$](?=[a-zA-Z0-9_]))[a-zA-Z0-9_]*[!=?]?"},i=(t.qString={token:"string",regex:"['](?:(?:\\\\.)|(?:[^'\\\\]))*?[']"},t.qqString={token:"string",regex:'["](?:(?:\\\\.)|(?:[^"\\\\]))*?["]'},t.tString={token:"string",regex:"[`](?:(?:\\\\.)|(?:[^'\\\\]))*?[`]"},t.constantNumericHex={token:"constant.numeric",regex:"0[xX][0-9a-fA-F](?:[0-9a-fA-F]|_(?=[0-9a-fA-F]))*\\b"}),o=t.constantNumericFloat={token:"constant.numeric",regex:"[+-]?\\d(?:\\d|_(?=\\d))*(?:(?:\\.\\d(?:\\d|_(?=\\d))*)?(?:[eE][+-]?\\d+)?)?\\b"},s=(t.instanceVariable={token:"variable.instance",regex:"@{1,2}[a-zA-Z_\\d]+"},function(){var e="abort|Array|assert|assert_equal|assert_not_equal|assert_same|assert_not_same|assert_nil|assert_not_nil|assert_match|assert_no_match|assert_in_delta|assert_throws|assert_raise|assert_nothing_raised|assert_instance_of|assert_kind_of|assert_respond_to|assert_operator|assert_send|assert_difference|assert_no_difference|assert_recognizes|assert_generates|assert_response|assert_redirected_to|assert_template|assert_select|assert_select_email|assert_select_rjs|assert_select_encoded|css_select|at_exit|attr|attr_writer|attr_reader|attr_accessor|attr_accessible|autoload|binding|block_given?|callcc|caller|catch|chomp|chomp!|chop|chop!|defined?|delete_via_redirect|eval|exec|exit|exit!|fail|Float|flunk|follow_redirect!|fork|form_for|form_tag|format|gets|global_variables|gsub|gsub!|get_via_redirect|host!|https?|https!|include|Integer|lambda|link_to|link_to_unless_current|link_to_function|link_to_remote|load|local_variables|loop|open|open_session|p|print|printf|proc|putc|puts|post_via_redirect|put_via_redirect|raise|rand|raw|readline|readlines|redirect?|request_via_redirect|require|scan|select|set_trace_func|sleep|split|sprintf|srand|String|stylesheet_link_tag|syscall|system|sub|sub!|test|throw|trace_var|trap|untrace_var|atan2|cos|exp|frexp|ldexp|log|log10|sin|sqrt|tan|render|javascript_include_tag|csrf_meta_tag|label_tag|text_field_tag|submit_tag|check_box_tag|content_tag|radio_button_tag|text_area_tag|password_field_tag|hidden_field_tag|fields_for|select_tag|options_for_select|options_from_collection_for_select|collection_select|time_zone_select|select_date|select_time|select_datetime|date_select|time_select|datetime_select|select_year|select_month|select_day|select_hour|select_minute|select_second|file_field_tag|file_field|respond_to|skip_before_filter|around_filter|after_filter|verify|protect_from_forgery|rescue_from|helper_method|redirect_to|before_filter|send_data|send_file|validates_presence_of|validates_uniqueness_of|validates_length_of|validates_format_of|validates_acceptance_of|validates_associated|validates_exclusion_of|validates_inclusion_of|validates_numericality_of|validates_with|validates_each|authenticate_or_request_with_http_basic|authenticate_or_request_with_http_digest|filter_parameter_logging|match|get|post|resources|redirect|scope|assert_routing|translate|localize|extract_locale_from_tld|caches_page|expire_page|caches_action|expire_action|cache|expire_fragment|expire_cache_for|observe|cache_sweeper|has_many|has_one|belongs_to|has_and_belongs_to_many",t="alias|and|BEGIN|begin|break|case|class|def|defined|do|else|elsif|END|end|ensure|__FILE__|finally|for|gem|if|in|__LINE__|module|next|not|or|private|protected|public|redo|rescue|retry|return|super|then|undef|unless|until|when|while|yield",r="true|TRUE|false|FALSE|nil|NIL|ARGF|ARGV|DATA|ENV|RUBY_PLATFORM|RUBY_RELEASE_DATE|RUBY_VERSION|STDERR|STDIN|STDOUT|TOPLEVEL_BINDING",n="$DEBUG|$defout|$FILENAME|$LOAD_PATH|$SAFE|$stdin|$stdout|$stderr|$VERBOSE|$!|root_url|flash|session|cookies|params|request|response|logger|self",s=this.$keywords=this.createKeywordMapper({keyword:t,"constant.language":r,"variable.language":n,"support.function":e,"invalid.deprecated":"debugger"},"identifier");this.$rules={start:[{token:"comment",regex:"#.*$"},{token:"comment",regex:"^=begin(?:$|\\s.*$)",next:"comment"},{token:"string.regexp",regex:"[/](?:(?:\\[(?:\\\\]|[^\\]])+\\])|(?:\\\\/|[^\\]/]))*[/]\\w*\\s*(?=[).,;]|$)"},[{regex:"[{}]",onMatch:function(e,t,r){return this.next="{"==e?this.nextState:"","{"==e&&r.length?(r.unshift("start",t),"paren.lparen"):"}"==e&&r.length&&(r.shift(),this.next=r.shift(),-1!=this.next.indexOf("string"))?"paren.end":"{"==e?"paren.lparen":"paren.rparen"},nextState:"start"},{token:"string.start",regex:/"/,push:[{token:"constant.language.escape",regex:/\\(?:[nsrtvfbae'"\\]|c.|C-.|M-.(?:\\C-.)?|[0-7]{3}|x[\da-fA-F]{2}|u[\da-fA-F]{4})/},{token:"paren.start",regex:/#{/,push:"start"},{token:"string.end",regex:/"/,next:"pop"},{defaultToken:"string"}]},{token:"string.start",regex:/`/,push:[{token:"constant.language.escape",regex:/\\(?:[nsrtvfbae'"\\]|c.|C-.|M-.(?:\\C-.)?|[0-7]{3}|x[\da-fA-F]{2}|u[\da-fA-F]{4})/},{token:"paren.start",regex:/#{/,push:"start"},{token:"string.end",regex:/`/,next:"pop"},{defaultToken:"string"}]},{token:"string.start",regex:/'/,push:[{token:"constant.language.escape",regex:/\\['\\]/},{token:"string.end",regex:/'/,next:"pop"},{defaultToken:"string"}]}],{token:"text",regex:"::"},{token:"variable.instance",regex:"@{1,2}[a-zA-Z_\\d]+"},{token:"support.class",regex:"[A-Z][a-zA-Z_\\d]+"},a,i,o,{token:"constant.language.boolean",regex:"(?:true|false)\\b"},{token:s,regex:"[a-zA-Z_$][a-zA-Z0-9_$]*\\b"},{token:"punctuation.separator.key-value",regex:"=>"},{stateName:"heredoc",onMatch:function(e,t,r){var n="-"==e[2]?"indentedHeredoc":"heredoc",s=e.split(this.splitRegex);return r.push(n,s[3]),[{type:"constant",value:s[1]},{type:"string",value:s[2]},{type:"support.class",value:s[3]},{type:"string",value:s[4]}]},regex:"(<<-?)(['\"`]?)([\\w]+)(['\"`]?)",rules:{heredoc:[{onMatch:function(e,t,r){return e===r[1]?(r.shift(),r.shift(),this.next=r[0]||"start","support.class"):(this.next="","string")},regex:".*$",next:"start"}],indentedHeredoc:[{token:"string",regex:"^ +"},{onMatch:function(e,t,r){return e===r[1]?(r.shift(),r.shift(),this.next=r[0]||"start","support.class"):(this.next="","string")},regex:".*$",next:"start"}]}},{regex:"$",token:"empty",next:function(e,t){return"heredoc"===t[0]||"indentedHeredoc"===t[0]?t[0]:e}},{token:"string.character",regex:"\\B\\?."},{token:"keyword.operator",regex:"!|\\$|%|&|\\*|\\-\\-|\\-|\\+\\+|\\+|~|===|==|=|!=|!==|<=|>=|<<=|>>=|>>>=|<>|<|>|!|&&|\\|\\||\\?\\:|\\*=|%=|\\+=|\\-=|&=|\\^=|\\b(?:in|instanceof|new|delete|typeof|void)"},{token:"paren.lparen",regex:"[[({]"},{token:"paren.rparen",regex:"[\\])}]"},{token:"text",regex:"\\s+"}],comment:[{token:"comment",regex:"^=end(?:$|\\s.*$)",next:"start"},{token:"comment",regex:".+"}]},this.normalizeRules()});r.inherits(s,n),t.RubyHighlightRules=s}),define("ace/mode/matching_brace_outdent",["require","exports","module","ace/range"],function(e,t){"use strict";var i=e("../range").Range,r=function(){};(function(){this.checkOutdent=function(e,t){return!!/^\s+$/.test(e)&&/^\s*\}/.test(t)},this.autoOutdent=function(e,t){var r=e.getLine(t).match(/^(\s*\})/);if(!r)return 0;var n=r[1].length,s=e.findMatchingBracket({row:t,column:n});if(!s||s.row==t)return 0;var a=this.$getIndent(e.getLine(s.row));e.replace(new i(t,0,t,n-1),a)},this.$getIndent=function(e){return e.match(/^\s*/)[0]}}).call(r.prototype),t.MatchingBraceOutdent=r}),define("ace/mode/folding/coffee",["require","exports","module","ace/lib/oop","ace/mode/folding/fold_mode","ace/range"],function(e,t){"use strict";var r=e("../../lib/oop"),n=e("./fold_mode").FoldMode,u=e("../../range").Range,s=t.FoldMode=function(){};r.inherits(s,n),function(){this.getFoldWidgetRange=function(e,t,r){var n=this.indentationBlock(e,r);if(n)return n;var s=/\S/,a=e.getLine(r),i=a.search(s);if(-1!=i&&"#"==a[i]){for(var o=a.length,c=e.getLength(),l=r,_=r;++r<c;){var d=(a=e.getLine(r)).search(s);if(-1!=d){if("#"!=a[d])break;_=r}}if(l<_){var g=e.getLine(_).length;return new u(l,o,_,g)}}},this.getFoldWidget=function(e,t,r){var n=e.getLine(r),s=n.search(/\S/),a=e.getLine(r+1),i=e.getLine(r-1),o=i.search(/\S/),c=a.search(/\S/);if(-1==s)return e.foldWidgets[r-1]=-1!=o&&o<c?"start":"","";if(-1==o){if(s==c&&"#"==n[s]&&"#"==a[s])return e.foldWidgets[r-1]="",e.foldWidgets[r+1]="","start"}else if(o==s&&"#"==n[s]&&"#"==i[s]&&-1==e.getLine(r-2).search(/\S/))return e.foldWidgets[r-1]="start",e.foldWidgets[r+1]="";return e.foldWidgets[r-1]=-1!=o&&o<s?"start":"",s<c?"start":""}}.call(s.prototype)}),define("ace/mode/ruby",["require","exports","module","ace/lib/oop","ace/mode/text","ace/mode/ruby_highlight_rules","ace/mode/matching_brace_outdent","ace/range","ace/mode/behaviour/cstyle","ace/mode/folding/coffee"],function(e,t){"use strict";var r=e("../lib/oop"),n=e("./text").Mode,s=e("./ruby_highlight_rules").RubyHighlightRules,a=e("./matching_brace_outdent").MatchingBraceOutdent,c=e("../range").Range,i=e("./behaviour/cstyle").CstyleBehaviour,o=e("./folding/coffee").FoldMode,l=function(){this.HighlightRules=s,this.$outdent=new a,this.$behaviour=new i,this.foldingRules=new o};r.inherits(l,n),function(){this.lineCommentStart="#",this.getNextLineIndent=function(e,t,r){var n=this.$getIndent(t),s=this.getTokenizer().getLineTokens(t,e).tokens;if(s.length&&"comment"==s[s.length-1].type)return n;if("start"==e){var a=t.match(/^.*[\{\(\[]\s*$/),i=t.match(/^\s*(class|def|module)\s.*$/),o=t.match(/.*do(\s*|\s+\|.*\|\s*)$/),c=t.match(/^\s*(if|else|when)\s*/);(a||i||o||c)&&(n+=r)}return n},this.checkOutdent=function(e,t,r){return/^\s+(end|else)$/.test(t+r)||this.$outdent.checkOutdent(t,r)},this.autoOutdent=function(e,t,r){var n=t.getLine(r);if(/}/.test(n))return this.$outdent.autoOutdent(t,r);var s=this.$getIndent(n),a=t.getLine(r-1),i=this.$getIndent(a),o=t.getTabString();i.length<=s.length&&s.slice(-o.length)==o&&t.remove(new c(r,s.length-o.length,r,s.length))},this.$id="ace/mode/ruby"}.call(l.prototype),t.Mode=l});