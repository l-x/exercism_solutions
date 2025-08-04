const codon_map = {
  'AUG': 'Methionine',
  'UUU': 'Phenylalanine',
  'UUC': 'Phenylalanine',
  'UUA': 'Leucine',
  'UUG': 'Leucine',
  'UCU': 'Serine',
  'UCC': 'Serine',
  'UCA': 'Serine',
  'UCG': 'Serine',
  'UAU': 'Tyrosine',
  'UAC': 'Tyrosine',
  'UGU': 'Cysteine',
  'UGC': 'Cysteine',
  'UGG': 'Tryptophan',
};

class ProteinTranslation {
  List<String> translate(String rna) {
    var proteins = <String>[];

    while (rna != '') {
      var codon = rna.substring(0, 3);
      rna = rna.substring(3);

      if (codon == 'UAA' || codon == 'UAG' || codon == 'UGA') {
        break;
      }

      var protein = codon_map[codon];
      if (protein == null) {
        throw ArgumentError();
      }

      proteins.add(protein);
    }

    return proteins;
  }
}
