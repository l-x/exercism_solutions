<?php

declare(strict_types=1);

final readonly class HighSchoolSweetheart
{
    private const HEART = <<<'HEART'
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     %s  +  %s     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    HEART;
    
    public function firstLetter(string $name): string
    {
        return trim($name)[0];
    }

    public function initial(string $name): string
    {
        return strtoupper($this->firstLetter($name)) . '.';
    }

    public function initials(string $name): string
    {
        return join(
            ' ', 
            array_map(
                $this->initial(...), 
                explode(' ', $name),
            ),
        );
    }

    public function pair(string $sweetheart_a, string $sweetheart_b): string
    {
        return sprintf(
            self::HEART, 
            $this->initials($sweetheart_a), 
            $this->initials($sweetheart_b),
        );
    }
}
