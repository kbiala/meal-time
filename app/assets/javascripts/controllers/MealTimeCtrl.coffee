angular.module('MealTimeModule').controller("MealTimeCtrl", ($rootScope, $scope, $http) ->
  $rootScope.facebookLoggedIn = false
  $rootScope.githubLoggedIn = false
  $scope.currentToken = ->
    return localStorage.satellizer_token || localStorage.facebook_token || null

  $scope.authorize = (token) ->
    $http({
      url: "/sessions/authenticate"
      params: { access_token: token }
    }).then (response) ->
      if response.data.facebook_id != null
        $rootScope.facebookLoggedIn = true
        $rootScope.facebookName = response.data.name
      else if response.data.github_id != null
        $rootScope.githubLoggedIn = true
        $rootScope.githubName = response.data.name
    , (response) ->
      console.log "authorization failure"

  $scope.loginAlert = ->
    alert("Please log in to continue")

  $scope.unknownError = ->
    alert("There was an error when processing your request")

  if (token = $scope.currentToken()) != null
    $scope.authorize(token)
)
