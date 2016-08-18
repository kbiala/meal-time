angular.module('MealTimeModule').controller("OrdersIndexCtrl", ($scope, $rootScope, orderResource) ->
  saveOrdersToScope = (orders) ->
    getActiveOrders = ->
      orders.filter (order) ->
        order.status != "Delivered"
    getDeliveredOrders = ->
      orders.filter (order) ->
        order.status == "Delivered"
    $rootScope.activeOrders = getActiveOrders()
    $rootScope.deliveredOrders = getDeliveredOrders()

  $scope.setCurrentOrder = (order) ->
    $rootScope.currentOrder = order

  orderResource.query({}, (response) -> saveOrdersToScope(response))
)
