class SVG

    # ZZZ Later, get from SVG module
    
    @NS: "http://www.w3.org/2000/svg"
    
    @element: (type) -> document.createElementNS @NS, type
    
    @attr: (el, p, v) -> el.setAttributeNS null, p, v
    
    @get: (el, p) -> el.getAttributeNS null, p
    
    @set: (el, props) ->
        for p, v of props
            @attr el, p, v

window.$foo = ->
    
    # ZZZ May need timeout, to make sure MathJax rendered?
    
    glyphs = $ "#MathJax_SVG_glyphs"
    displayHtml "mj1", glyphs[0].outerHTML, true
    
    mj = $ "#omega"
    displayHtml "mj1", mj.html()
    
    mjSvg = $ ".MathJax_SVG"
    displayHtml "mj1", mjSvg[0].outerHTML # ZZZ could be more elements
    
    svg = mjSvg.find "svg"
    displayHtml "mj1", svg[0].outerHTML
    
    #console.log "SVG", SVG
    
    viewBox = svg[0].viewBox
    console.log "vb", svg, viewBox
    y = viewBox.baseVal.y
    console.log "y", y
    w = viewBox.baseVal.width
    h = viewBox.baseVal.height
    
    mjgClone = $ "myClone"
    if mjgClone.length is 0
        mjg = svg.find "g"
        mjgClone = mjg.clone()
        mjgClone.attr "id", "myClone"
        #console.log "mjg", mjg, mjg[0].outerHTML 
    
    # or...
    sf = 0.025
    xt = 20
    yt = 40 + (-sf * y)
    m = mjgClone[0]
    #m.setAttribute "fill", "blue"
    m.setAttribute "transform", "translate(#{xt} #{yt}) scale(#{sf}) matrix(1 0 0 -1 0 0)"
    #console.log "mjg modified", m, m.fill, m.outerHTML
    
    diagram = $ "#diagram"
    diagram.append glyphs
    diagram.append $(m)
    console.log "diagram", diagram, diagram[0].outerHTML
    
    
    #g = SVG.element "g"
    #diagram[0].appendChild g
    displayHtml "mj1", diagram[0].outerHTML 

    
displayHtml = (id, html, empty=false) ->
    container = $ "##{id}"
    container.empty() if empty
    pre = $ "<pre>"
        css:
            fontSize: "10pt"
            lineHeight: "110%"
    container.append pre
    pre.text formatXml(html)

#!end (4)

