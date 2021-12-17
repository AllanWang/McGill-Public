class Exc(msg: String) : RuntimeException(msg)

fun String.indexOf(key: String, err: String): Int {
    val i = indexOf(key)
    if (i == -1) throw Exc(err)
    return i
}

fun String.lastIndexOf(key: String, err: String): Int {
    val i = lastIndexOf(key)
    if (i == -1) throw Exc(err)
    return i
}

tailrec fun String.indexOf(key: String, index: Int): Int {
    val i = indexOf(key, "Index of mismatch")
    return if (index > 1) substring(i + key.length).indexOf(key, index - 1)
    else i
}

fun String.countSubstring(sub: String) = split(sub).size - 1

fun variable(input: String): Pair<String, Boolean> = with(input.trim()) {
    if (startsWith("(")) {
        if (!endsWith(")")) throw Exc("bracket mismatch")
        val (fst, snd) = substring(1, length - 1).split(",")
        return "\"${fst.trim()}\", \"${snd.trim()}\"" to true
    }
    return "\"$this\"" to false
}

fun declaration(input: String): String = with(input.trim()) {
    val eq = indexOf("=", "declaration has no =")
    val (dec, isPair) = variable(substring(0, eq))
    val exp = convert(substring(eq + 1))
    return "${if (isPair) "E.Match" else "E.Val"} ($exp, $dec)"
}

fun convert(input: String): String = with(input.trim()) {
    if (DEBUG) println("'$this'")
    if (startsWith("(")) {
        if (!endsWith(")")) throw Exc("bracket mismatch")
        val sub = substring(1, length - 1).trim()
        if (!contains(",")) return convert(sub)
        val (fst, snd) = sub.split(",")
        return "E.Pair (${convert(fst)}, ${convert(snd)})"
    } else if (startsWith("let")) {
        val firstIn = indexOf("in", "no in found")
        val letCount = substring(0, firstIn).countSubstring("let")
        val validIn = indexOf("in", letCount)
        val e1 = substring(3, validIn)
        val e2 = substring(validIn + 2)
        return "E.Let (${declaration(e1)}, ${convert(e2)})"
    } else if (startsWith("if")) {
        val firstThen = indexOf("then", "if then mismatch")
        val thenCount = substring(0, firstThen).countSubstring("if")
        val validThen = indexOf("then", thenCount)
        val cond = substring(2, validThen)
        val `else` = lastIndexOf("else")
        val `true` = substring(validThen + 4, `else`)
        val `false` = substring(`else` + 4)
        return "E.If (${convert(cond)}, ${convert(`true`)}, ${convert(`false`)})"
    } else if (!contains(" ")) {
        return toIntOrBool() ?: "E.Var \"$this\""
    } else {
        val tokens = split(" ")
        val _0 = convert(tokens[0])
        return when (tokens[1]) {
            "=" -> "E.Primop (E.Equals, [$_0; ${convert(substring(indexOf("=") + 1))}])"
            "+" -> "E.Primop (E.Plus, [$_0; ${convert(substring(indexOf("+") + 1))}])"
            "*" -> "E.Primop (E.Times, [$_0; ${convert(substring(indexOf("*") + 1))}])"
            "-" -> "E.Primop (E.Minus, [$_0; ${convert(substring(indexOf("-") + 1))}])"
            else -> this
        }
    }
}

fun String.toIntOrBool(): String? {
    val i = toIntOrNull()
    return if (i != null) "E.Int $i"
    else if (this == "true" || this == "false") "E.Bool ${toBoolean()}"
    else null
}

private var _inputs = mutableListOf<Pair<String, String>>()

fun generate(vararg inputs: Pair<String, String>) = _inputs.addAll(inputs)

fun generateInt(vararg inputs: Pair<String, Int>) = _inputs.addAll(inputs.map { (exp, i) -> exp to "Int $i" })

fun build() = _inputs.mapIndexed { index, (equation, expected) ->
    val name = "test$index"
    "let $name = ${convert(equation.toLowerCase())};;\n\ne' \"$name\" ($expected) $name \"$equation\";;"
}.joinToString("\n\n\n")

fun printExp() = println((if (DEBUG) "\n\n\n" else "") + build())

const val DEBUG = false

fun main(args: Array<String>) {
    generateInt(
            "if 3 = 2 then 5 + 3 * 5 else 1 + 3 * 5" to 16,
            "let x = 7 in 9" to 9,
            "let x = 7 in x" to 7,
            "let (x, y) = (3, false) in if y then x + 1 else 7" to 7,
            "let (x, y) = (3, false) in x + 1" to 4,
            "let (x, y) = (3, false) in if false then 1 else 2" to 2,
            "let z = 3 in let x = 7 in let y = x in z" to 3,
            "let (x, y) = (3, 2) in x + y" to 5,
            "let (x, y) = (false, 7) in if x then 1 else y" to 7,
            "let (x, y) = (1, 2) in let (a, b) = (x, y) in a + b" to 3
    )

    printExp()

}