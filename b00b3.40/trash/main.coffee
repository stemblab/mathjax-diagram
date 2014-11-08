first = true
window.$myfun = ->
    if first
        setTimeout (-> $foo()), 1000
        first = false
    else
        $foo()
puzletInit.register (-> $myfun())
#$pz.JS (-> $myfun()) #, ["mathjax"]

#!end (6)

