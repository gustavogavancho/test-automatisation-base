@REQ_SANDBOX-001 @HU001 @character_management @marvel_characters_api @Agente2 @E2 @demo_marvel
Feature: SANDBOX-001 Gestión de personajes Marvel

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
  Scenario: T-API-MARV-101-CA02-Crear personaje válido 201 - karate
    * def uuid = java.util.UUID.randomUUID().toString()

    * def body =
      """
      {
        "name": "Spider-Man-#(uuid)",
        "alterego": "Peter Parker",
        "description": "Superhéroe arácnido de Marvel",
        "powers": ["Agilidad", "Sentido arácnido", "Trepar muros"]
      }
      """

    Given path '/characters'
    And request body
    When method post
    Then status 201
  # And match response.name == body.name
  # And match response.id != null

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

  @id:5 @crearPersonaje @error500
  Scenario: T-API-MARV-101-CA04-Crear personaje - error interno 500 - karate
    Given path '/characters/force-error'
    When method get
    Then status 500
  # And match response.message contains 'Internal Server Error'
  # And match response.status == 500