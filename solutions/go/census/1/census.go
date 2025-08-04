package census

type Resident struct {
	Name    string
	Age     int
	Address map[string]string
}

func NewResident(name string, age int, address map[string]string) *Resident {
	return &Resident{name, age, address}
}

func (r *Resident) HasRequiredInfo() bool {
	if r.Name == "" {
		return false
	}

	if r.Address["street"] == "" {
		return false
	}

	return true
}

func (r *Resident) Delete() {
	r.Name = ""
	r.Age = 0
	r.Address = nil
}

func Count(residents []*Resident) (count int) {
	for _, resident := range residents {
		if resident.HasRequiredInfo() {
			count++
		}
	}

	return
}
