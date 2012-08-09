// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.SetView = (function(_super) {

    __extends(SetView, _super);

    function SetView() {
      return SetView.__super__.constructor.apply(this, arguments);
    }

    SetView.prototype.template_first = _.template($("#set_view_first").html());

    SetView.prototype.template = _.template($("#set_view").html());

    SetView.prototype.initialize = function() {
      _.bindAll(this);
      this.model.bind('change', this.render);
      return this.render();
    };

    SetView.prototype.render = function() {
      if (this.model.get('posiiton') === 1) {
        this.setElement(this.template_first(this.model.toJSON()));
      } else {
        this.setElement(this.template(this.model.toJSON()));
      }
      return this;
    };

    return SetView;

  })(Backbone.View);

}).call(this);
