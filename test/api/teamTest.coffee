ld = require 'lodash'
{expect}  = require 'chai'
testUtils = require '../testUtils'
lol       = require '../../src/lol'

describe 'team API', ->
    it 'should fetch summoners by name', ->
        client = lol.client {
            apiKey: 'TESTKEY'
            cache: lol.lruCache(50)
        }
        testUtils.expectRequest(client,
            "https://na.api.pvp.net/api/lol/na/v2.4/team/by-summoner/24125166",
            'team/bySummoner.json')

        client.getTeamsBySummoner 'na', 24125166
        .then (value) ->
            expect(value).to.exist
            expect(value[24125166]).to.exist
            expect(value[24125166][0].fullId).to.equal "TEAM-9b6cd830-1ff0-11e2-a4e5-782bcb4d1861"

    it 'should fetch summoners by team ID', ->
        teamId = "TEAM-9b6cd830-1ff0-11e2-a4e5-782bcb4d1861"
        client = lol.client {
            apiKey: 'TESTKEY'
            cache: lol.lruCache(50)
        }
        testUtils.expectRequest(client,
            "https://na.api.pvp.net/api/lol/na/v2.4/team/TEAM-9b6cd830-1ff0-11e2-a4e5-782bcb4d1861",
            'team/byTeamId.json')

        client.getTeams 'na', teamId
        .then (value) ->
            expect(value).to.exist
            expect(value[teamId]).to.exist
            expect(value[teamId].fullId).to.equal teamId
