module.exports = {
    "env": {
        "browser": true,
        "es2021": true
    },
    "extends": [
        "standard-with-typescript",
        "plugin:react/recommended"
    ],
    "overrides": [
        {
            "env": {
                "node": true
            },
            "files": [
                ".eslintrc.{js,cjs}"
            ],
            "parserOptions": {
                "sourceType": "script"
            }
        }
    ],
    parser: '@typescript-eslint/parser',
    "parserOptions": {
        "ecmaVersion": "latest",
        project: ['./tsconfig.json'],
        "sourceType": "module"
    },
    "plugins": [
        "react"
    ],
    settings: {
        react: {
            version: "detect"
        },
    },
    "rules": {
        "@typescript-eslint/explicit-function-return-type": "off",
        "@typescript-eslint/triple-slash-reference": "off",
        "@typescript-eslint/explicit-function-return-type": "off",
        "@typescript-eslint/no-floating-promises": "off",
        "react/jsx-indent" : ["error", 2],
        "react/jsx-indent-props": ["error", 2]
    }
}
