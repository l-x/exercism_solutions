<?php

declare(strict_types=1);

final readonly class Lasagna
{
    private const COOK_TIME = 40;
    private const MINUTES_PER_LAYER = 2;
    
    public function expectedCookTime(): int
    {
        return self::COOK_TIME;
    }

    public function remainingCookTime(int $elapsed_minutes): int
    {
        return self::COOK_TIME - $elapsed_minutes;
    }

    public function totalPreparationTime(int $layers_to_prep): int
    {
        return $layers_to_prep * self::MINUTES_PER_LAYER;
    }

    public function totalElapsedTime(int $layers_to_prep, int $elapsed_minutes): int
    {
        return $this->totalPreparationTime($layers_to_prep) + $elapsed_minutes;
    }

    public function alarm(): string
    {
        return 'Ding!';
    }
}
