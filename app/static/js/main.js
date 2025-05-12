// Initialize tooltips and popovers
document.addEventListener('DOMContentLoaded', function() {
    // Bootstrap initialization
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl);
    });
    
    // Smooth fade-in effect for content containers
    const contentContainer = document.querySelector('.content-container');
    if (contentContainer) {
        contentContainer.style.opacity = '0';
        setTimeout(() => {
            contentContainer.style.opacity = '1';
            contentContainer.style.transition = 'opacity 0.5s ease-in-out';
        }, 100);
    }
    
    // File upload functionality
    const fileUploadForm = document.getElementById('fileUploadForm');
    const uploadArea = document.querySelector('.upload-area');
    const fileInput = document.getElementById('file');
    const uploadProgress = document.getElementById('uploadProgress');
    const progressBar = document.querySelector('.progress-bar');
    
    if (fileUploadForm && uploadArea && fileInput) {
        // Drag and drop functionalities
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, preventDefaults, false);
        });
        
        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }
        
        ['dragenter', 'dragover'].forEach(eventName => {
            uploadArea.addEventListener(eventName, highlight, false);
        });
        
        ['dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, unhighlight, false);
        });
        
        function highlight() {
            uploadArea.classList.add('dragover');
        }
        
        function unhighlight() {
            uploadArea.classList.remove('dragover');
        }
        
        uploadArea.addEventListener('drop', handleDrop, false);
        
        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;
            fileInput.files = files;
            updateFileLabel();
        }
        
        // Update file label when file is selected
        fileInput.addEventListener('change', updateFileLabel);
        
        function updateFileLabel() {
            const fileName = fileInput.files[0]?.name;
            const fileLabel = document.querySelector('.custom-file-label');
            if (fileLabel) {
                fileLabel.textContent = fileName || 'Choose file';
            }
        }
        
        // Handle form submission with progress bar
        fileUploadForm.addEventListener('submit', function(e) {
            if (fileInput.files.length === 0) return;
            
            if (uploadProgress) {
                uploadProgress.classList.remove('d-none');
                simulateUploadProgress();
            }
        });
        
        // Simulate upload progress for demonstration purposes
        // In a production environment, you would use XMLHttpRequest or Fetch API to track real upload progress
        function simulateUploadProgress() {
            let width = 0;
            const interval = setInterval(() => {
                if (width >= 100) {
                    clearInterval(interval);
                } else {
                    width += (100 - width) / 10;
                    if (width > 95) width = 100;
                    progressBar.style.width = width + '%';
                    progressBar.setAttribute('aria-valuenow', width);
                }
            }, 200);
        }
    }
    
    // Reimbursement form amount validation
    const amountInput = document.getElementById('amount');
    if (amountInput) {
        amountInput.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9.]/g, '');
        });
    }
    
    // Add smooth transition when showing QR code
    const qrCodeContainer = document.querySelector('.qr-code-container');
    if (qrCodeContainer) {
        qrCodeContainer.style.opacity = '0';
        setTimeout(() => {
            qrCodeContainer.style.opacity = '1';
            qrCodeContainer.style.transition = 'opacity 0.5s ease-in-out';
        }, 300);
    }
    
    // Add animation to status badges
    const badges = document.querySelectorAll('.badge');
    badges.forEach(badge => {
        badge.style.opacity = '0';
        badge.style.transform = 'scale(0.8)';
        setTimeout(() => {
            badge.style.opacity = '1';
            badge.style.transform = 'scale(1)';
            badge.style.transition = 'opacity 0.3s ease-in-out, transform 0.3s ease-in-out';
        }, Math.random() * 300);
    });
    
    // Add animation to cards
    const cards = document.querySelectorAll('.card');
    cards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
            card.style.transition = 'opacity 0.5s ease-in-out, transform 0.5s ease-in-out';
        }, 100 + (index * 100));
    });
});
