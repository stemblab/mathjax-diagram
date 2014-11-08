// Generated by CoffeeScript 1.4.0
(function() {
  var SVG, displayHtml;

  SVG = (function() {

    function SVG() {}

    SVG.NS = "http://www.w3.org/2000/svg";

    SVG.element = function(type) {
      return document.createElementNS(this.NS, type);
    };

    SVG.attr = function(el, p, v) {
      return el.setAttributeNS(null, p, v);
    };

    SVG.get = function(el, p) {
      return el.getAttributeNS(null, p);
    };

    SVG.set = function(el, props) {
      var p, v, _results;
      _results = [];
      for (p in props) {
        v = props[p];
        _results.push(this.attr(el, p, v));
      }
      return _results;
    };

    return SVG;

  })();

  window.$foo = function() {
    var diagram, glyphs, h, m, mj, mjSvg, mjg, mjgClone, sf, svg, viewBox, w, xt, y, yt;
    glyphs = $("#MathJax_SVG_glyphs");
    displayHtml("mj1", glyphs[0].outerHTML, true);
    mj = $("#omega");
    displayHtml("mj1", mj.html());
    mjSvg = $(".MathJax_SVG");
    displayHtml("mj1", mjSvg[0].outerHTML);
    svg = mjSvg.find("svg");
    displayHtml("mj1", svg[0].outerHTML);
    viewBox = svg[0].viewBox;
    console.log("vb", svg, viewBox);
    y = viewBox.baseVal.y;
    console.log("y", y);
    w = viewBox.baseVal.width;
    h = viewBox.baseVal.height;
    mjgClone = $("myClone");
    if (mjgClone.length === 0) {
      mjg = svg.find("g");
      mjgClone = mjg.clone();
      mjgClone.attr("id", "myClone");
    }
    sf = 0.025;
    xt = 20;
    yt = 40 + (-sf * y);
    m = mjgClone[0];
    m.setAttribute("transform", "translate(" + xt + " " + yt + ") scale(" + sf + ") matrix(1 0 0 -1 0 0)");
    diagram = $("#diagram");
    diagram.append(glyphs);
    diagram.append($(m));
    console.log("diagram", diagram, diagram[0].outerHTML);
    return displayHtml("mj1", diagram[0].outerHTML);
  };

  displayHtml = function(id, html, empty) {
    var container, pre;
    if (empty == null) {
      empty = false;
    }
    container = $("#" + id);
    if (empty) {
      container.empty();
    }
    pre = $("<pre>", {
      css: {
        fontSize: "10pt",
        lineHeight: "110%"
      }
    });
    container.append(pre);
    return pre.text(formatXml(html));
  };

}).call(this);
