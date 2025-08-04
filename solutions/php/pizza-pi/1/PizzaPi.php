<?php

declare(strict_types=1);

use function pi;
use function pow;

final readonly class PizzaPi
{
    public function calculateDoughRequirement(int $pizzas, int $persons): int
    {
        return (200 + $persons * 20) * $pizzas;
    }

    public function calculateSauceRequirement(int $pizzas, int $can_volume): int
    {
        return (int) ceil($pizzas * 125 / $can_volume);
    }

    public function calculateCheeseCubeCoverage(
        int $side_length, 
        float $desired_thickness, 
        int $pizza_diameter,
    ): int {
        return (int) (pow($side_length, 3) / ($desired_thickness * pi() * $pizza_diameter)); 
    }

    public function calculateLeftOverSlices(int $pizzas, int $persons): int
    {
        return ($pizzas * 8) % $persons;
    }
}
