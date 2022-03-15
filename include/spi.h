/*
 * Firmware for the Portenta X8 STM32H747AIIX/Cortex-M7 core.
 * Copyright (C) 2022 Arduino (http://www.arduino.cc/)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#ifndef SPI_H
#define SPI_H

/**************************************************************************************
 * INCLUDE
 **************************************************************************************/

#include <inttypes.h>

/**************************************************************************************
 * FUNCTION DECLARATION
 **************************************************************************************/

void spi_init();

void spi_end();

void spi_transmit_receive(uint8_t peripheral, uint8_t *tx_buf, uint8_t *rx_buf, uint16_t size);

#endif  //SPI_H
