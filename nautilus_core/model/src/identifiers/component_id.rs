// -------------------------------------------------------------------------------------------------
//  Copyright (C) 2015-2022 Nautech Systems Pty Ltd. All rights reserved.
//  https://nautechsystems.io
//
//  Licensed under the GNU Lesser General Public License Version 3.0 (the "License");
//  You may not use this file except in compliance with the License.
//  You may obtain a copy of the License at https://www.gnu.org/licenses/lgpl-3.0.en.html
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
// -------------------------------------------------------------------------------------------------

use nautilus_core::string::{pystr_to_string, string_to_pystr};
use pyo3::ffi;
use std::collections::hash_map::DefaultHasher;
use std::fmt::{Debug, Display, Formatter, Result};
use std::hash::{Hash, Hasher};

#[repr(C)]
#[derive(Clone, Hash, PartialEq, Debug)]
#[allow(clippy::box_collection)] // C ABI compatibility
pub struct ComponentId {
    value: Box<String>,
}

impl From<&str> for ComponentId {
    fn from(s: &str) -> ComponentId {
        ComponentId {
            value: Box::new(s.to_string()),
        }
    }
}

impl Display for ComponentId {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        write!(f, "{}", self.value)
    }
}

////////////////////////////////////////////////////////////////////////////////
// C API
////////////////////////////////////////////////////////////////////////////////
#[no_mangle]
pub extern "C" fn component_id_free(component_id: ComponentId) {
    drop(component_id); // Memory freed here
}

/// Returns a Nautilus identifier from a valid Python object pointer.
///
/// # Safety
/// - `ptr` must be borrowed from a valid Python UTF-8 `str`.
#[no_mangle]
pub unsafe extern "C" fn component_id_from_pystr(ptr: *mut ffi::PyObject) -> ComponentId {
    ComponentId {
        value: Box::new(pystr_to_string(ptr)),
    }
}

/// Returns a pointer to a valid Python UTF-8 string.
///
/// # Safety
/// - Assumes that since the data is originating from Rust, the GIL does not need
/// to be acquired.
/// - Assumes you are immediately returning this pointer to Python.
#[no_mangle]
pub unsafe extern "C" fn component_to_pystr(component_id: &ComponentId) -> *mut ffi::PyObject {
    string_to_pystr(component_id.value.as_str())
}

/// Returns a pointer to a valid Python UTF-8 string.
///
/// # Safety
/// - Assumes that since the data is originating from Rust, the GIL does not need
/// to be acquired.
/// - Assumes you are immediately returning this pointer to Python.
#[no_mangle]
pub unsafe extern "C" fn component_id_to_pystr(component_id: &ComponentId) -> *mut ffi::PyObject {
    string_to_pystr(component_id.value.as_str())
}

#[no_mangle]
pub extern "C" fn component_id_eq(lhs: &ComponentId, rhs: &ComponentId) -> u8 {
    (lhs == rhs) as u8
}

#[no_mangle]
pub extern "C" fn component_id_hash(component_id: &ComponentId) -> u64 {
    let mut h = DefaultHasher::new();
    component_id.hash(&mut h);
    h.finish()
}

////////////////////////////////////////////////////////////////////////////////
// Tests
////////////////////////////////////////////////////////////////////////////////
#[cfg(test)]
mod tests {
    use super::ComponentId;
    use crate::identifiers::component_id::component_id_free;

    #[test]
    fn test_equality() {
        let id1 = ComponentId::from("RiskEngine");
        let id2 = ComponentId::from("DataEngine");

        assert_eq!(id1, id1);
        assert_ne!(id1, id2);
    }

    #[test]
    fn test_string_reprs() {
        let id = ComponentId::from("RiskEngine");

        assert_eq!(id.to_string(), "RiskEngine");
        assert_eq!(format!("{id}"), "RiskEngine");
    }

    #[test]
    fn test_component_id_free() {
        let id = ComponentId::from("001");

        component_id_free(id); // No panic
    }
}
