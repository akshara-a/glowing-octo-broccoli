import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

interface CurrentWeather {
  time: string;
  temperature_2m: number;
  relative_humidity_2m: number;
  apparent_temperature: number;
  wind_speed_10m: number;
  weather_code: number;
}

interface OpenMeteoResponse {
  latitude: number;
  longitude: number;
  timezone: string;
  current: CurrentWeather;
  current_units: Record<string, string>;
}

@Component({
  selector: 'app-open-meteo-weather',
  imports: [FormsModule],
  templateUrl: './open-meteo-weather.html',
  styleUrl: './open-meteo-weather.css',
})
export class OpenMeteoWeather {
  latitude = 12.9716;
  longitude = 77.5946;
  weather?: OpenMeteoResponse;
  errorMessage = '';
  isLoading = false;

  async getWeather(): Promise<void> {
    this.errorMessage = '';
    this.weather = undefined;

    if (!this.isValidCoordinate(this.latitude, -90, 90)) {
      this.errorMessage = 'Latitude must be between -90 and 90.';
      return;
    }

    if (!this.isValidCoordinate(this.longitude, -180, 180)) {
      this.errorMessage = 'Longitude must be between -180 and 180.';
      return;
    }

    this.isLoading = true;

    try {
      const params = new URLSearchParams({
        latitude: String(this.latitude),
        longitude: String(this.longitude),
        current:
          'temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,weather_code',
        timezone: 'auto',
      });

      const response = await fetch(
        `https://api.open-meteo.com/v1/forecast?${params.toString()}`
      );

      if (!response.ok) {
        throw new Error('Unable to load weather data.');
      }

      this.weather = (await response.json()) as OpenMeteoResponse;
    } catch {
      this.errorMessage = 'Could not fetch weather data. Please try again.';
    } finally {
      this.isLoading = false;
    }
  }

  getWeatherLabel(code: number): string {
    const labels: Record<number, string> = {
      0: 'Clear sky',
      1: 'Mainly clear',
      2: 'Partly cloudy',
      3: 'Overcast',
      45: 'Fog',
      48: 'Depositing rime fog',
      51: 'Light drizzle',
      53: 'Moderate drizzle',
      55: 'Dense drizzle',
      61: 'Slight rain',
      63: 'Moderate rain',
      65: 'Heavy rain',
      71: 'Slight snow',
      73: 'Moderate snow',
      75: 'Heavy snow',
      80: 'Slight rain showers',
      81: 'Moderate rain showers',
      82: 'Violent rain showers',
      95: 'Thunderstorm',
    };

    return labels[code] ?? `Weather code ${code}`;
  }

  private isValidCoordinate(value: number, min: number, max: number): boolean {
    return Number.isFinite(value) && value >= min && value <= max;
  }
}
