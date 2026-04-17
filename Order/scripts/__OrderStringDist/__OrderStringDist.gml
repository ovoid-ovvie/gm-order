// Feather disable all

function __OrderStringDist(a, b) {
    if (a == b) return 0;
    
    var la = string_length(a);
    var lb = string_length(b);
    
    if (la == 0) return lb;
    if (lb == 0) return la;

    var v0 = array_create(lb + 1);
    var v1 = array_create(lb + 1);
    var v2 = array_create(lb + 1);

    for (var i = 0; i <= lb; i++) v0[i] = i;

    for (var i = 1; i <= la; i++) {
        v1[0] = i;
        for (var j = 1; j <= lb; j++) {
            var cost = (string_char_at(a, i) == string_char_at(b, j)) ? 0 : 1;
            v1[j] = min(v1[j - 1] + 1, v0[j] + 1, v0[j - 1] + cost);
            
            if (i > 1 && j > 1 && string_char_at(a, i) == string_char_at(b, j - 1) && string_char_at(a, i - 1) == string_char_at(b, j)) {
                v1[j] = min(v1[j], v2[j - 2] + 1);
            }
        }
        array_copy(v2, 0, v0, 0, lb + 1);
        array_copy(v0, 0, v1, 0, lb + 1);
    }

    return v0[lb];
}
