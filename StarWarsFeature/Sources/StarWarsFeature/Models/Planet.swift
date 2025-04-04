import Foundation

public struct SWPlanetsResponse: Codable, Hashable, Sendable {
	public let count: Int
	public let next: String?
	public let previous: String?
	public let planets: [SWPlanet]
	
	enum CodingKeys: String, CodingKey {
		case count, next, previous
		case planets = "results"
	}
}

public struct SWPlanet: Identifiable, Codable, Hashable, Sendable {
	public let id: String = UUID().uuidString

	public let name, rotationPeriod, orbitalPeriod, diameter: String
	public let climate, gravity, terrain, surfaceWater: String
	public let population: String
	public let residents, films: [String]
	public let created, edited: String
	public let url: String
	
	public init(name: String, rotationPeriod: String, orbitalPeriod: String, diameter: String, climate: String, gravity: String, terrain: String, surfaceWater: String, population: String, residents: [String], films: [String], created: String, edited: String, url: String) {
		self.name = name
		self.rotationPeriod = rotationPeriod
		self.orbitalPeriod = orbitalPeriod
		self.diameter = diameter
		self.climate = climate
		self.gravity = gravity
		self.terrain = terrain
		self.surfaceWater = surfaceWater
		self.population = population
		self.residents = residents
		self.films = films
		self.created = created
		self.edited = edited
		self.url = url
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.name = try container.decode(String.self, forKey: .name)
		self.rotationPeriod = try container.decode(String.self, forKey: .rotationPeriod)
		self.orbitalPeriod = try container.decode(String.self, forKey: .orbitalPeriod)
		self.diameter = try Decimal(
			string: container.decode(
				String.self,
				forKey: .diameter
			))?
			.formatted(.number).description ?? "0"
		self.climate = try container.decode(String.self, forKey: .climate)
		self.gravity = try container.decode(String.self, forKey: .gravity)
		self.terrain = try container.decode(String.self, forKey: .terrain)
		
		let rawSurfaceWater = try container.decode(String.self, forKey: .surfaceWater)
		self.surfaceWater = rawSurfaceWater.lowercased() == "unknown" ? "0" : rawSurfaceWater
		
		let rawPopulation = try container.decode(String.self, forKey: .population)
		let decimalPopulation = Decimal(string: rawPopulation) ?? 0
		self.population = decimalPopulation.formatted(.number).description
		self.residents = try container.decode([String].self, forKey: .residents)
		self.films = try container.decode([String].self, forKey: .films)
		self.created = try container.decode(String.self, forKey: .created)
		self.edited = try container.decode(String.self, forKey: .edited)
		self.url = try container.decode(String.self, forKey: .url)
	}
	
	enum CodingKeys: String, CodingKey {
		case name
		case rotationPeriod = "rotation_period"
		case orbitalPeriod = "orbital_period"
		case diameter, climate, gravity, terrain
		case surfaceWater = "surface_water"
		case population, residents, films, created, edited, url
	}
}

extension SWPlanet {
	public static let `default` = SWPlanet(
		name: "Naboo",
		rotationPeriod: "26",
		orbitalPeriod: "312",
		diameter: "12120",
		climate: "temperate",
		gravity: "1 standard",
		terrain: "grassy hills, swamps, forests, mountains",
		surfaceWater: "12",
		population: "4500000000",
		residents: [],
		films: [],
		created: "2014-12-09T13:50:49.644Z",
		edited: "2014-12-10T13:59:28.459Z",
		url: "https://swapi.dev/api/planets/8/"
	)
}

extension SWPlanetsResponse {
	public static var noop: SWPlanetsResponse {
		.init(count: 0, next: "", previous: nil, planets: [])
	}
}
