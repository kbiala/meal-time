app = angular.module("MealTimeModule", ["templates", "ui.router", "ngResource"])

app.config ($stateProvider) ->
  $stateProvider
    .state 'root',
      url: ''
      templateUrl: 'index.html'
    .state 'orders',
      url: '/orders'
      template: "<ui-view/>"
      abstract: true
    .state 'orders.index',
      url: '/'
      templateUrl: 'orders/index.html'
      controller: 'OrdersIndexCtrl'
    .state 'orders.show',
      url: '/:id'
      templateUrl: 'orders/show.html'
      controller: 'OrdersShowCtrl'

app.factory "orderResource", ($resource) ->
  $resource("/orders/:id", {}, {
    update: {method: "PUT"}
  })

app.factory "mealResource", ($resource) ->
  $resource("/orders/:order_id/meals/:id", {}, {
    update: {method: "PUT"}
  })
