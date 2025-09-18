<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBU Management</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <!-- React and Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/react@18.2.0/umd/react.development.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/react-dom@18.2.0/umd/react-dom.development.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/babel-standalone@7.22.9/Babel.min.js"></script>
    <style>
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background: white;
            border-radius: 0.5rem;
            width: 90%;
            max-width: 600px;
            animation: fadeIn 0.3s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 10000;
            min-width: 300px;
            opacity: 0;
            transform: translateY(-20px);
            transition: all 0.5s ease;
        }
        .toast.show {
            opacity: 1;
            transform: translateY(0);
        }
        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        input:checked + .slider {
            background-color: #4F7C82;
        }
        input:checked + .slider:before {
            transform: translateX(26px);
        }
    </style>
</head>
<body>
    <div id="root"></div>

    <script type="text/babel">
        const { useState, useEffect } = React;

        // Mock data for SBUs and profit centers
        const mockSbus = [
            { id: 1, entity_code: "ENT001", entity_name: "Entity A", profit_center_code: "PC001", profit_center_name: "Profit Center 1", sbu: "SBU1", employee_name: "John Doe", employee_id: "E001", email_id: "john.doe@example.com", created_on: "2023-01-01", modified_on: "2023-06-01", status: "Active", role: "Admin" },
            { id: 2, entity_code: "ENT002", entity_name: "Entity B", profit_center_code: "PC002,PC003", profit_center_name: "Profit Center 2, Profit Center 3", sbu: "SBU2", employee_name: "Jane Smith", employee_id: "E002", email_id: "jane.smith@example.com", created_on: "2023-02-01", modified_on: "2023-07-01", status: "Inactive", role: "Management" },
        ];

        const mockProfitCenters = [
            { profit_center_code: "PC001", profit_center_name: "Profit Center 1" },
            { profit_center_code: "PC002", profit_center_name: "Profit Center 2" },
            { profit_center_code: "PC003", profit_center_name: "Profit Center 3" },
        ];

        // Toast component
        const Toast = ({ message, type, onClose }) => {
            useEffect(() => {
                const timer = setTimeout(onClose, 5000);
                return () => clearTimeout(timer);
            }, []);

            return (
                <div className={`toast show bg-${type === 'success' ? 'green-100' : 'red-100'} border-l-4 border-${type === 'success' ? 'green-500' : 'red-500'} p-4 rounded shadow-lg`}>
                    <div className="flex justify-between items-center">
                        <span>{message}</span>
                        <button onClick={onClose} className="text-gray-500 hover:text-gray-700">
                            <i className="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            );
        };

        // Modal component
        const Modal = ({ isOpen, onClose, children }) => {
            if (!isOpen) return null;
            return (
                <div className="modal-overlay">
                    <div className="modal-content p-6">
                        {children}
                    </div>
                </div>
            );
        };

        // Main App component
        const App = () => {
            const [sbus, setSbus] = useState(mockSbus);
            const [search, setSearch] = useState("");
            const [showAddModal, setShowAddModal] = useState(false);
            const [showEditModal, setShowEditModal] = useState(null);
            const [toast, setToast] = useState({ show: false, message: "", type: "" });

            const filteredSbus = sbus.filter(sbu =>
                Object.values(sbu).some(val =>
                    val.toString().toLowerCase().includes(search.toLowerCase())
                )
            );

            const showToast = (message, type) => {
                setToast({ show: true, message, type });
            };

            const closeToast = () => {
                setToast({ show: false, message: "", type: "" });
            };

            return (
                <div className="container mx-auto p-4">
                    {toast.show && <Toast message={toast.message} type={toast.type} onClose={closeToast} />}
                    <div className="flex justify-between mb-4">
                        <button
                            onClick={() => window.location.href = '/back'}
                            className="bg-gray-800 text-white px-4 py-2 rounded flex items-center hover:bg-gray-700 transition"
                        >
                            <i className="fas fa-arrow-left mr-2"></i> Back
                        </button>
                        <button
                            onClick={() => window.location.href = '/logout'}
                            className="border border-gray-800 text-gray-800 px-4 py-2 rounded flex items-center hover:bg-gray-100 transition"
                        >
                            <i className="fas fa-sign-out-alt mr-2"></i> Logout
                        </button>
                    </div>

                    <div className="bg-gradient-to-r from-teal-600 to-teal-800 text-white p-6 rounded-lg shadow-lg mb-6">
                        <div className="flex justify-between items-center">
                            <div>
                                <h2 className="text-2xl font-bold"><i className="fas fa-users mr-2"></i>SBU Management</h2>
                                <p>Manage system SBUs and their permissions</p>
                            </div>
                            <button
                                onClick={() => setShowAddModal(true)}
                                className="bg-white text-teal-800 px-4 py-2 rounded hover:bg-gray-100 transition"
                            >
                                <i className="fas fa-plus mr-2"></i>Add SBU
                            </button>
                        </div>
                    </div>

                    <div className="bg-white rounded-lg shadow-lg p-6">
                        <input
                            type="text"
                            placeholder="Search SBUs..."
                            value={search}
                            onChange={e => setSearch(e.target.value)}
                            className="w-full p-2 mb-4 border rounded"
                        />
                        <div className="overflow-x-auto">
                            <table className="w-full table-auto">
                                <thead className="bg-gray-800 text-white">
                                    <tr>
                                        <th className="p-2">ID</th>
                                        <th className="p-2">Entity Code</th>
                                        <th className="p-2">Entity Name</th>
                                        <th className="p-2">Profit Center Code</th>
                                        <th className="p-2">Profit Center Name</th>
                                        <th className="p-2">SBU</th>
                                        <th className="p-2">Employee Name</th>
                                        <th className="p-2">Employee ID</th>
                                        <th className="p-2">Email ID</th>
                                        <th className="p-2">Created Date</th>
                                        <th className="p-2">Modified Date</th>
                                        <th className="p-2">Status</th>
                                        <th className="p-2">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {filteredSbus.map((sbu, index) => (
                                        <tr key={sbu.id} className="hover:bg-teal-50 transition">
                                            <td className="p-2">{filteredSbus.length - index}</td>
                                            <td className="p-2">{sbu.entity_code}</td>
                                            <td className="p-2">{sbu.entity_name}</td>
                                            <td className="p-2">{sbu.profit_center_code.split(',').join(', ')}</td>
                                            <td className="p-2">{sbu.profit_center_name}</td>
                                            <td className="p-2">{sbu.sbu}</td>
                                            <td className="p-2">{sbu.employee_name}</td>
                                            <td className="p-2">{sbu.employee_id}</td>
                                            <td className="p-2">{sbu.email_id}</td>
                                            <td className="p-2">{sbu.created_on}</td>
                                            <td className="p-2">{sbu.modified_on}</td>
                                            <td className="p-2">
                                                <span className={`px-2 py-1 rounded-full text-xs ${sbu.status === 'Active' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
                                                    {sbu.status}
                                                </span>
                                            </td>
                                            <td className="p-2">
                                                <button
                                                    onClick={() => setShowEditModal(sbu)}
                                                    className="bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-600 transition"
                                                >
                                                    <i className="fas fa-edit"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>

                    {/* Add SBU Modal */}
                    <AddSbuModal
                        isOpen={showAddModal}
                        onClose={() => setShowAddModal(false)}
                        sbus={sbus}
                        profitCenters={mockProfitCenters}
                        onAdd={newSbu => {
                            setSbus([...sbus, { ...newSbu, id: sbus.length + 1, created_on: new Date().toISOString().split('T')[0], modified_on: new Date().toISOString().split('T')[0] }]);
                            setShowAddModal(false);
                            showToast("SBU added successfully", "success");
                        }}
                        showToast={showToast}
                    />

                    {/* Edit SBU Modal */}
                    <EditSbuModal
                        isOpen={showEditModal !== null}
                        onClose={() => setShowEditModal(null)}
                        sbu={showEditModal}
                        sbus={sbus}
                        profitCenters={mockProfitCenters}
                        onUpdate={updatedSbu => {
                            setSbus(sbus.map(s => s.id === updatedSbu.id ? { ...updatedSbu, modified_on: new Date().toISOString().split('T')[0] } : s));
                            setShowEditModal(null);
                            showToast("SBU updated successfully", "success");
                        }}
                        showToast={showToast}
                    />
                </div>
            );
        };

        // Add SBU Modal Component
        const AddSbuModal = ({ isOpen, onClose, sbus, profitCenters, onAdd, showToast }) => {
            const [formData, setFormData] = useState({
                entity_code: "", entity_name: "", profit_center_code: "", profit_center_name: "", sbu: "", employee_name: "", employee_id: "", email_id: "", status: "Active", role: ""
            });
            const [isMultiple, setIsMultiple] = useState(false);
            const [emailValid, setEmailValid] = useState(null);

            const validateEmail = email => {
                if (!email) return false;
                const existing = sbus.find(s => s.email_id === email && s.status === "Active");
                return !existing;
            };

            const handleSubmit = e => {
                e.preventDefault();
                if (!validateEmail(formData.email_id)) {
                    showToast("Email already exists with Active status", "danger");
                    return;
                }
                if (formData.role === "Management" && isMultiple && (!formData.profit_center_code || formData.profit_center_code.length === 0)) {
                    showToast("Please select at least one profit center", "danger");
                    return;
                }
                if (formData.role !== "Management" && !formData.profit_center_code) {
                    showToast("Please select a profit center", "danger");
                    return;
                }
                onAdd({
                    ...formData,
                    profit_center_code: isMultiple ? formData.profit_center_code.join(',') : formData.profit_center_code,
                    profit_center_name: isMultiple ? profitCenters.filter(pc => formData.profit_center_code.includes(pc.profit_center_code)).map(pc => pc.profit_center_name).join(', ') : profitCenters.find(pc => pc.profit_center_code === formData.profit_center_code)?.profit_center_name || ""
                });
            };

            return (
                <Modal isOpen={isOpen} onClose={onClose}>
                    <form onSubmit={handleSubmit}>
                        <div className="flex justify-between items-center mb-4">
                            <h2 className="text-xl font-bold"><i className="fas fa-plus mr-2"></i>Add New SBU</h2>
                            <button type="button" onClick={onClose} className="text-gray-500 hover:text-gray-700">
                                <i className="fas fa-times"></i>
                            </button>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <label className="block text-sm font-medium">SBU ID</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.sbu}
                                    onChange={e => setFormData({ ...formData, sbu: e.target.value })}
                                    required
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Email <span className="text-red-500">*</span></label>
                                <input
                                    type="email"
                                    className="w-full p-2 border rounded"
                                    value={formData.email_id}
                                    onChange={e => {
                                        const email = e.target.value;
                                        setFormData({ ...formData, email_id: email });
                                        setEmailValid(validateEmail(email));
                                    }}
                                    required
                                />
                                {formData.email_id && (
                                    <div className={`text-sm mt-1 ${emailValid ? 'text-green-500' : 'text-red-500'}`}>
                                        {emailValid ? <><i className="fas fa-check-circle"></i> Email is available</> : <><i className="fas fa-exclamation-circle"></i> Email already exists with Active status</>}
                                    </div>
                                )}
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Entity Code</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.entity_code}
                                    onChange={e => setFormData({ ...formData, entity_code: e.target.value })}
                                    required
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Entity Name</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.entity_name}
                                    onChange={e => setFormData({ ...formData, entity_name: e.target.value })}
                                    required
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Employee Name</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.employee_name}
                                    onChange={e => setFormData({ ...formData, employee_name: e.target.value })}
                                    required
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Employee ID</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.employee_id}
                                    onChange={e => setFormData({ ...formData, employee_id: e.target.value })}
                                    required
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Role</label>
                                <select
                                    className="w-full p-2 border rounded"
                                    value={formData.role}
                                    onChange={e => setFormData({ ...formData, role: e.target.value })}
                                    required
                                >
                                    <option value="">Select Role</option>
                                    <option value="Admin">Admin</option>
                                    <option value="SBU">SBU</option>
                                    <option value="Management">Management</option>
                                    <option value="SA">Super Admin</option>
                                </select>
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Status</label>
                                <select
                                    className="w-full p-2 border rounded"
                                    value={formData.status}
                                    onChange={e => setFormData({ ...formData, status: e.target.value })}
                                    required
                                >
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>
                        </div>
                        {formData.role === "Management" && (
                            <div className="mt-4">
                                <div className="flex items-center mb-4">
                                    <label className="switch">
                                        <input
                                            type="checkbox"
                                            checked={isMultiple}
                                            onChange={e => setIsMultiple(e.target.checked)}
                                        />
                                        <span className="slider"></span>
                                    </label>
                                    <span className="ml-2">Multiple Profit Centers</span>
                                </div>
                                {isMultiple ? (
                                    <div>
                                        <label className="block text-sm font-medium">Select Profit Centers</label>
                                        <select
                                            multiple
                                            className="w-full p-2 border rounded"
                                            value={formData.profit_center_code}
                                            onChange={e => setFormData({ ...formData, profit_center_code: Array.from(e.target.selectedOptions, option => option.value) })}
                                        >
                                            {profitCenters.map(pc => (
                                                <option key={pc.profit_center_code} value={pc.profit_center_code}>
                                                    {pc.profit_center_code} - {pc.profit_center_name}
                                                </option>
                                            ))}
                                        </select>
                                    </div>
                                ) : (
                                    <div>
                                        <label className="block text-sm font-medium">Profit Center Code</label>
                                        <select
                                            className="w-full p-2 border rounded"
                                            value={formData.profit_center_code}
                                            onChange={e => setFormData({ ...formData, profit_center_code: e.target.value })}
                                        >
                                            <option value="">Select Profit Center</option>
                                            {profitCenters.map(pc => (
                                                <option key={pc.profit_center_code} value={pc.profit_center_code}>
                                                    {pc.profit_center_code} - {pc.profit_center_name}
                                                </option>
                                            ))}
                                        </select>
                                    </div>
                                )}
                            </div>
                        )}
                        {formData.role !== "Management" && (
                            <div className="mt-4">
                                <label className="block text-sm font-medium">Profit Center Code</label>
                                <select
                                    className="w-full p-2 border rounded"
                                    value={formData.profit_center_code}
                                    onChange={e => setFormData({ ...formData, profit_center_code: e.target.value })}
                                    required
                                >
                                    <option value="">Select Profit Center</option>
                                    {profitCenters.map(pc => (
                                        <option key={pc.profit_center_code} value={pc.profit_center_code}>
                                            {pc.profit_center_code} - {pc.profit_center_name}
                                        </option>
                                    ))}
                                </select>
                            </div>
                        )}
                        <div className="flex justify-end mt-4">
                            <button type="button" onClick={onClose} className="bg-gray-500 text-white px-4 py-2 rounded mr-2 hover:bg-gray-600 transition">
                                Close
                            </button>
                            <button
                                type="submit"
                                className={`bg-teal-600 text-white px-4 py-2 rounded hover:bg-teal-700 transition ${emailValid === false ? 'opacity-50 cursor-not-allowed' : ''}`}
                                disabled={emailValid === false}
                            >
                                Add SBU
                            </button>
                        </div>
                    </form>
                </Modal>
            );
        };

        // Edit SBU Modal Component
        const EditSbuModal = ({ isOpen, onClose, sbu, sbus, profitCenters, onUpdate, showToast }) => {
            const [formData, setFormData] = useState(sbu || {});
            const [isMultiple, setIsMultiple] = useState(sbu?.profit_center_code?.includes(',') || false);
            const [emailValid, setEmailValid] = useState(true);

            useEffect(() => {
                if (sbu) {
                    setFormData({
                        ...sbu,
                        profit_center_code: sbu.profit_center_code?.includes(',') ? sbu.profit_center_code.split(',') : sbu.profit_center_code || ""
                    });
                    setIsMultiple(sbu.profit_center_code?.includes(',') || false);
                }
            }, [sbu]);

            const validateEmail = email => {
                if (!email) return false;
                if (email === sbu?.email_id) return true;
                const existing = sbus.find(s => s.email_id === email && s.status === "Active");
                return !existing;
            };

            const handleSubmit = e => {
                e.preventDefault();
                if (!validateEmail(formData.email_id)) {
                    showToast("Email already exists with Active status", "danger");
                    return;
                }
                if (formData.role === "Management" && isMultiple && (!formData.profit_center_code || formData.profit_center_code.length === 0)) {
                    showToast("Please select at least one profit center", "danger");
                    return;
                }
                if (formData.role !== "Management" && !formData.profit_center_code) {
                    showToast("Please select a profit center", "danger");
                    return;
                }
                onUpdate({
                    ...formData,
                    profit_center_code: isMultiple ? formData.profit_center_code.join(',') : formData.profit_center_code,
                    profit_center_name: isMultiple ? profitCenters.filter(pc => formData.profit_center_code.includes(pc.profit_center_code)).map(pc => pc.profit_center_name).join(', ') : profitCenters.find(pc => pc.profit_center_code === formData.profit_center_code)?.profit_center_name || ""
                });
            };

            return (
                <Modal isOpen={isOpen} onClose={onClose}>
                    <form onSubmit={handleSubmit}>
                        <div className="flex justify-between items-center mb-4">
                            <h2 className="text-xl font-bold"><i className="fas fa-edit mr-2"></i>Edit SBU</h2>
                            <button type="button" onClick={onClose} className="text-gray-500 hover:text-gray-700">
                                <i className="fas fa-times"></i>
                            </button>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                            <div>
                                <label className="block text-sm font-medium">SBU ID</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.sbu}
                                    readOnly
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Email <span className="text-red-500">*</span></label>
                                <input
                                    type="email"
                                    className="w-full p-2 border rounded"
                                    value={formData.email_id}
                                    onChange={e => {
                                        const email = e.target.value;
                                        setFormData({ ...formData, email_id: email });
                                        setEmailValid(validateEmail(email));
                                    }}
                                    required
                                />
                                {formData.email_id && (
                                    <div className={`text-sm mt-1 ${emailValid ? 'text-green-500' : 'text-red-500'}`}>
                                        {emailValid ? <><i className="fas fa-check-circle"></i> Email is available</> : <><i className="fas fa-exclamation-circle"></i> Email already exists with Active status</>}
                                    </div>
                                )}
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Entity Code</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.entity_code}
                                    onChange={e => setFormData({ ...formData, entity_code: e.target.value })}
                                    required
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Entity Name</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.entity_name}
                                    onChange={e => setFormData({ ...formData, entity_name: e.target.value })}
                                    required
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Employee Name</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.employee_name}
                                    onChange={e => setFormData({ ...formData, employee_name: e.target.value })}
                                    required
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Employee ID</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border rounded"
                                    value={formData.employee_id}
                                    onChange={e => setFormData({ ...formData, employee_id: e.target.value })}
                                    required
                                />
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Role</label>
                                <select
                                    className="w-full p-2 border rounded"
                                    value={formData.role}
                                    onChange={e => setFormData({ ...formData, role: e.target.value })}
                                    required
                                >
                                    <option value="Admin">Admin</option>
                                    <option value="SBU">SBU</option>
                                    <option value="Management">Management</option>
                                    <option value="SA">Super Admin</option>
                                </select>
                            </div>
                            <div>
                                <label className="block text-sm font-medium">Status</label>
                                <select
                                    className="w-full p-2 border rounded"
                                    value={formData.status}
                                    onChange={e => setFormData({ ...formData, status: e.target.value })}
                                    required
                                >
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>
                        </div>
                        {formData.role === "Management" && (
                            <div className="mt-4">
                                <div className="flex items-center mb-4">
                                    <label className="switch">
                                        <input
                                            type="checkbox"
                                            checked={isMultiple}
                                            onChange={e => setIsMultiple(e.target.checked)}
                                        />
                                        <span className="slider"></span>
                                    </label>
                                    <span className="ml-2">Multiple Profit Centers</span>
                                </div>
                                {isMultiple ? (
                                    <div>
                                        <label className="block text-sm font-medium">Select Profit Centers</label>
                                        <select
                                            multiple
                                            className="w-full p-2 border rounded"
                                            value={formData.profit_center_code}
                                            onChange={e => setFormData({ ...formData, profit_center_code: Array.from(e.target.selectedOptions, option => option.value) })}
                                        >
                                            {profitCenters.map(pc => (
                                                <option key={pc.profit_center_code} value={pc.profit_center_code}>
                                                    {pc.profit_center_code} - {pc.profit_center_name}
                                                </option>
                                            ))}
                                        </select>
                                    </div>
                                ) : (
                                    <div>
                                        <label className="block text-sm font-medium">Profit Center Code</label>
                                        <select
                                            className="w-full p-2 border rounded"
                                            value={formData.profit_center_code}
                                            onChange={e => setFormData({ ...formData, profit_center_code: e.target.value })}
                                        >
                                            <option value="">Select Profit Center</option>
                                            {profitCenters.map(pc => (
                                                <option key={pc.profit_center_code} value={pc.profit_center_code}>
                                                    {pc.profit_center_code} - {pc.profit_center_name}
                                                </option>
                                            ))}
                                        </select>
                                    </div>
                                )}
                            </div>
                        )}
                        {formData.role !== "Management" && (
                            <div className="mt-4">
                                <label className="block text-sm font-medium">Profit Center Code</label>
                                <select
                                    className="w-full p-2 border rounded"
                                    value={formData.profit_center_code}
                                    onChange={e => setFormData({ ...formData, profit_center_code: e.target.value })}
                                    required
                                >
                                    <option value="">Select Profit Center</option>
                                    {profitCenters.map(pc => (
                                        <option key={pc.profit_center_code} value={pc.profit_center_code}>
                                            {pc.profit_center_code} - {pc.profit_center_name}
                                        </option>
                                    ))}
                                </select>
                            </div>
                        )}
                        <div className="flex justify-end mt-4">
                            <button type="button" onClick={onClose} className="bg-gray-500 text-white px-4 py-2 rounded mr-2 hover:bg-gray-600 transition">
                                Close
                            </button>
                            <button
                                type="submit"
                                className={`bg-teal-600 text-white px-4 py-2 rounded hover:bg-teal-700 transition ${emailValid === false ? 'opacity-50 cursor-not-allowed' : ''}`}
                                disabled={emailValid === false}
                            >
                                Save Changes
                            </button>
                        </div>
                    </form>
                </Modal>
            );
        };

        // Render the app
        ReactDOM.render(<App />, document.getElementById('root'));
    </script>
</body>
</html>