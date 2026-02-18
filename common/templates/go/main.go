package main

import (
	"fmt"
	"runtime"
	"strings"
	"unicode"
)

func hello_world(action string) {
	// 1. Get the Program Counter (PC) of the current function
	pc, _, _, _ := runtime.Caller(0)

	// 2. Get the full function name (e.g., "main.hello_world")
	fullFuncName := runtime.FuncForPC(pc).Name()

	// 3. Strip the package path to get just "hello_world"
	// Splits "main.hello_world" and takes the last part
	parts := strings.Split(fullFuncName, ".")
	funcName := parts[len(parts)-1]

	// 4. Split into words: "hello", "world"
	words := strings.Split(funcName, "_")

	// 5. Capitalize each word: "Hello", "World"
	for i, w := range words {
		runes := []rune(w)
		runes[0] = unicode.ToUpper(runes[0])
		words[i] = string(runes)
	}

	// 6. Join with ", " and add "!" -> "Hello, World!"
	finalString := strings.Join(words, ", ") + "!"

	// 7. Execute the action
	if action == "print" {
		fmt.Println(finalString)
	}
}

func main() {
	hello_world("print")
}
