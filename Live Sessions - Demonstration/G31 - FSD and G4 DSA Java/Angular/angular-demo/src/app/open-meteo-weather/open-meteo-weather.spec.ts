import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OpenMeteoWeather } from './open-meteo-weather';

describe('OpenMeteoWeather', () => {
  let component: OpenMeteoWeather;
  let fixture: ComponentFixture<OpenMeteoWeather>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OpenMeteoWeather],
    }).compileComponents();

    fixture = TestBed.createComponent(OpenMeteoWeather);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should validate latitude before calling the API', async () => {
    component.latitude = 100;

    await component.getWeather();

    expect(component.errorMessage).toContain('Latitude');
  });
});
