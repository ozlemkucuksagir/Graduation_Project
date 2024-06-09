package com.example.hotel_gp.Service;

import com.example.hotel_gp.Entity.Hotel;

import java.util.List;
import java.util.Optional;

public interface HotelService {
    List<Hotel> findAll();
   
    List<Hotel> findByAllColumnsContainingAndNumberGreaterThanEqual(String feature, int number);
    Optional<Hotel> findHotelById(int id);
    List<Hotel> getAllHotelsSortedByPrice();
}
