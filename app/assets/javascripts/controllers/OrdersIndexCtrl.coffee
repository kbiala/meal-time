angular.module('MealTimeModule').controller("OrdersIndexCtrl", ($scope, orderResource) ->
  $scope.orders = orderResource.query({access_token: $scope.currentToken()}, (->), ->
    $scope.loginAlert()
  )

  $scope.addOrder = ->
    order = orderResource.save({order: $scope.newOrder, access_token: $scope.currentToken()}, ->
      $scope.orders.push(order)
    , ->
      $scope.loginAlert()
    )
    $scope.newOrder = {}
)
