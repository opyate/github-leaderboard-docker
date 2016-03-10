'use strict';

angular.module('myApp.config', [])
  .constant('config', {
    github: {
      api_uri: 'https://api.github.com',
      auth_token: %GITHUB_TOKEN%
    },
    projects: [
%PROJECTS%
    ],

    // Average amount of additions/deletions per commit
    commitment_average_add: 60,
    commitment_average_delete: 30
  });
