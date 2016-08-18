angular.module('MealTimeModule').controller("OrdersNewCtrl", ($scope, $rootScope, orderResource) ->
  $scope.addOrder = ->
    order = orderResource.save({order: $scope.newOrder, access_token: $scope.currentToken()}, ->
      $rootScope.activeOrders.push(order)
    , (response) ->
      if response.data.error
        alert(response.data.error)
      else if response.status == 401
        $scope.loginAlert()
      else
        $scope.unknownError()
    )
    $scope.newOrder = {}
)
