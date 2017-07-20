(function() {
    'use strict';

    angular
        .module('coocotteApp')
        .controller('HomeController', HomeController);

    HomeController.$inject = ['$scope', 'Principal', 'LoginService', '$state', '$http'];

    function HomeController ($scope, Principal, LoginService, $state, $http) {
        var vm = this;

        vm.account = null;
        vm.isAuthenticated = null;
        vm.login = LoginService.open;
        vm.register = register;
        $scope.$on('authenticationSuccess', function() {
            getAccount();
        });

        getAccount();

        function getAccount() {
            Principal.identity().then(function(account) {
                vm.account = account;
                vm.isAuthenticated = Principal.isAuthenticated;
            });
        }
        function register () {
            $state.go('register');
        }

        vm.articles = null;
        $http({
          method: 'GET',
          url: 'api/articles'
        }).then(function successCallback(response) {
            vm.articles = response.data;
        }, function errorCallback(response) {
            console.error("Impossible d'obtenir les articles");
        });

    }
})();
