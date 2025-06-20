@REQ_SANDBOX-001 @HU001 @character_management @marvel_characters_api @Agente2 @E2 @demo_marvel
Feature: SANDBOX-001 Gestión de personajes Marvel (microservicio público de ejemplo)

  Background:
    * url port_marvel_characters_api
    * configure ssl = true

  # Obtener todos los personajes – 200
  @id:1 @listarPersonajes @exitoso200
  Scenario: T-API-SANDBOX-001-CA01-Listar personajes 200 - karate
    Given path '/characters'
    When method get
    Then status 200
  # And match response == '#[] ? _ != null'

  # Crear personaje válido – 201
  @id:2 @crearPersonaje @exitoso201
  Scenario: T-API-SANDBOX-001-CA02-Crear personaje válido 201 - karate
    * def body = read('classpath:data/marvel_characters_api/request_crear_personaje.json')
    Given path '/characters'
    And request body
    When method post
    Then status 201
  # And match response.name == body.name

  # Crear personaje duplicado – 400
  @id:3 @crearPersonajeDuplicado @error400
  Scenario: T-API-SANDBOX-001-CA03-Crear personaje duplicado 400 - karate
    * def body = read('classpath:data/marvel_characters_api/request_crear_personaje.json')
    Given path '/characters'
    And request body
    When method post
    Then status 400
  # And match response.message contains 'duplicate'

  # Consultar personaje inexistente – 404
  @id:4 @consultarInexistente @error404
  Scenario: T-API-SANDBOX-001-CA04-Consultar personaje inexistente 404 - karate
    Given path '/characters/9999'
    When method get
    Then status 404
  # And match response.message contains 'not found'