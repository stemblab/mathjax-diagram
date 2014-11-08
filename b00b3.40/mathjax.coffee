window.console ?= {log: ->}

run = (f) -> 
    # mathjaxPreConfig is a Puzlet event.
    $(document).on "mathjaxPreConfig", =>
        MathJax.Hub.Register.StartupHook "End", (-> f())
        
xmlString = ($xmlObj) ->
    serializer = new XMLSerializer()
    xml = serializer.serializeToString $xmlObj[0]
    prettyXml = vkbeautify.xml xml
        
dispXml = (divId, obj) ->
    return unless obj
    div = $ "##{divId}"
    pre = $ "<pre>"
        css:
            padding: "10px"
            fontSize: "10pt"
            lineHeight: "110%"
            background: "#ffe"
    div.append pre
    prettyXml = xmlString obj
    pre.text prettyXml

#!end (13)

run ->
    source = $("#mathjaxSource").find ".MathJax_SVG"
    dispXml "mathjax", source

#!end (25)

class MathJaxObject

    constructor: (@divId, @scale=0.02) ->
        @source = $("##{@divId}").find ".MathJax_SVG"
        @svg = @source.find "svg"
        g = @svg.find "g"
        @group = $(g[0]).clone()
        @translate 0, 0
            
    viewBox: -> @svg[0].viewBox
    
    width: -> @scale * @viewBox().baseVal.width
    
    height: -> @scale * @viewBox().baseVal.height
     
    translate: (@dx, @dy) ->
        dy = @dy + (-@scale * @viewBox().baseVal.y)
        @group[0].setAttribute "transform", 
            "translate(#{@dx} #{dy}) scale(#{@scale}) matrix(1 0 0 -1 0 0)"
                
    appendTo: (diagram) ->
        diagram.append @group

#!end (14)

show = (divId, mathjaxId, f=null) ->
    run ->
        div = $ "##{divId}"  # Div to display diagram
        diagram = $("#diagram").clone()  # Clone original SVG diagram
        diagram.attr "id", "diagram_"+mathjaxId  # Cloned diagram id
        div.append diagram
    
        obj = new MathJaxObject mathjaxId  # MathJax object
        f?(obj)  # Optional callback for object (e.g., translation)
        obj.appendTo diagram  # Append MathJax object to diagram
        dispXml divId, diagram

show "mathjaxAtOrigin", "mathjaxSource"

#!end (28)

rect = (id) ->
    # Returns an object that contains the coordinates and dimensions
    # of a ractangle element.
    r = $ "##{id}"
    val = (p) -> r[0][p].baseVal.value 
    coords =
        x: val "x"
        y: val "y"
        width: val "width"
        height: val "height"

show "mathjaxInBox", "mathjaxSource", (obj) ->
    r = rect "yellowBox"
    obj.translate r.x, r.y

#!end (17)

show "mathjaxCenteredInBox", "mathjaxSource", (obj) ->
    r = rect "yellowBox"
    x = r.x + (r.width - obj.width())/2
    y = r.y + (r.height - obj.height())/2
    obj.translate x, y

#!end (21)

run ->
    
    # Clone diagram.
    divId = "mathjaxAdvanced"
    div = $ "##{divId}"
    diagram = $("#diagram").clone()
    diagram.attr "id", "advancedDiagram"
    div.append diagram
    r = rect "yellowBox"  # Yellow box

    # Center integral in box.
    integral = new MathJaxObject "mathjaxIntegral"
    xI = r.x + (r.width - integral.width())/2
    yI = r.y + (r.height - integral.height())/2
    integral.translate xI, yI
    integral.appendTo diagram   # Append MathJax object to diagram

    # Position gamma equation vertically-centered to right of box.
    gamma = new MathJaxObject "mathjaxGamma"
    xG = r.x + r.width + 20
    yG = r.y + (r.height - gamma.height())/2
    gamma.translate xG, yG
    gamma.appendTo diagram

#!end (33)

run ->
    
    # Diagram from example above
    diagram = $ "#advancedDiagram"
    
    # Include MathJax glyphs at start of diagram's SVG.
    glyphs = $ "#MathJax_SVG_glyphs"
    diagram.prepend glyphs
    
    # Display diagram's SVG in highlighted textarea.
    # xmlString is pre-defined function to convert XML object to string.
    xml = xmlString diagram
    textArea = $ "<textarea>",
        text: xml
        rows: 40, readonly: true
        css: 
            width: "720px"
            overflow: "auto"
            whiteSpace: "pre"
    $("#standaloneSVG").append textArea

#!end (37)

class SVG

    # ZZZ Later, get from SVG module
    
    @NS: "http://www.w3.org/2000/svg"
    
    @element: (type) -> document.createElementNS @NS, type
    
    @attr: (el, p, v) -> el.setAttributeNS null, p, v
    
    @get: (el, p) -> el.getAttributeNS null, p
    
    @set: (el, props) ->
        for p, v of props
            @attr el, p, v

#!end (12)

