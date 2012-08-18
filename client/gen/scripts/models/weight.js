// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Weight = (function(_super) {

    __extends(Weight, _super);

    function Weight() {
      return Weight.__super__.constructor.apply(this, arguments);
    }

    Weight.prototype.defaults = {
      sets: [],
      comment: ''
    };

    Weight.prototype.initialize = function() {
      return this.sets = this.nestCollection('sets', new App.Sets(this.get('sets')));
    };

    Weight.prototype.validate = function(attr) {
      var name;
      name = attr.name.trim();
      if (name.split(' ').join('').length === 0) {
        return 'Exercise name must not be empty';
      }
    };

    return Weight;

  })(Backbone.Model);

}).call(this);
