public protocol SWPlanetsProvider {
	var fetchPlanets: () async throws -> SWPlanetsResponse { get }
	var fetchFilms: () async throws -> SWFilmResponse { get }
	var fetchPeople: () async throws -> SWPeopleResponse { get }
}
