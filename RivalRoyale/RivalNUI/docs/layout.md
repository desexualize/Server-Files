# Layout for NUI

This document is a general guideline towards these directories.

## SRC Directory

- [**components/**](../src/components/): Shared UI components which are being handled in utils or reused in multiple modules.
- [**modules/**](../src/modules/): Pages with their contents.
- [**submodules/**](../src/submodules/): Sub Pages that are being rendered in modules.
- [**styling/**](../src/styling/): Contains the main scss files where variables, mixins and functions are declared but used globally.
- [**utils/**](../src/utils/): Static and related methods that can be used anywhere and handle the state.
- [**stores/**](../src/stores/): State management stores using Zustand.
